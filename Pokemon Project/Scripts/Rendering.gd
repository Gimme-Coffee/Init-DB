extends Node

#Instanced scenes
const TreeScene = preload("res://Scenes/Environment/Tree.tscn")
#Paths to nodes in tree
onready var Map = get_node("/root/Map")
onready var elevation = get_node("/root/Map/World/Elevation")
#Files array from directory
var files : Array
#Initial array to add the secondary arrays to
var characters : Array

func _ready():
	#search_directory_for_files("res://Data/Maps/map_01")
	pass

func search_directory_for_files(path):
	files = []
	#Open desired directory
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	#Append files to array
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with(".csv"):
			files.append(path + "/" + file)
	#Stop looking for files
	dir.list_dir_end()
	#Result
	for f in files:
		load_csv_map_data(f)

func load_csv_map_data(file_path : String):
	var maindata = []
	#Open file from Data folder
	var f = File.new()
	var err = f.open(file_path, f.READ)
	if err != OK:
		return err
	#Get lines from file and create 2D array
	while !f.eof_reached():
		var data_set = f.get_csv_line()
		maindata.append(data_set)
	f.close()
	#Result
	print(maindata)
	get_tile_position(maindata)

func load_string_map_data(text, height, width):
	var pos = 0
	var array : Array
	var mainArray : Array
	#Deconstruct string into an array of single characters
	for c in range(text.length()):
		array.append(text.substr(pos, 1))
		pos += 1
	#Create a 2D array based on a set height and width, from top-left to bottom-right
	for y in range(height):
		mainArray.append([])
		mainArray[y].resize(width)
		for x in range(width):
			var value = array.pop_front()
			mainArray[y][x] = value
	#Result
	print(mainArray)
	get_tile_position(mainArray)

func get_tile_position(text):
	#Set array
	characters = text
	#Array to map conversion
	if characters.size() > 0:
		for y in range(characters.size()):
			for x in range(characters[y].size()):
				set_tiles(x, y)

func set_tiles(x_pos, y_pos):
	var ground = 4
	#For every position compare tile value and set appropriate tile/scene
	match characters[y_pos][x_pos]:
		#Base background tile
		".", "0":
			#set_tile(x_pos, y_pos, ground)
			pass
		#Water auto tile
		"~", "213", "214", "215", "221", "222", "223", "229", "230", "231":
			#set_tile(x_pos, y_pos, 1)
			pass
		"G", "93":
			set_tile(x_pos, y_pos, 0)
			pass
		#Path auto tile
		"_", "3080", "3081", "3082", "3168", "3169", "3170":
			set_tile(x_pos, y_pos, 1)
		#Tree scene at bottom-right position
		"T", "271":
			instance_scene(TreeScene, "Tree", x_pos, y_pos)
	#Update bitmask to make sure auto tiles connect correctly
	Map.update_bitmask_region()

func set_tile(x, y, tile : int):
	#Set the specified tile to the TileMap
	Map.set_cell(x + 1, y + 1, tile)

func instance_scene(scene, name, x, y):
	#Create/instanciate
	var newNode = Node2D.new()
	var newScene = scene.instance()
	#Set Node's properties
	newNode.name = name
	newNode.position = Vector2((x + 1) * 16, (y + 2) * 16)
	#Add childs to tree structure (the scene is a child of node2D)
	newNode.add_child(newScene)
	elevation.add_child(newNode)
