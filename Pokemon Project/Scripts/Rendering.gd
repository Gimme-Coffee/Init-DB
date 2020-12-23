extends Node

const InteractiblePokeBall = preload("res://Scenes/Environment/Pokeball.tscn")
const TreeScene = preload("res://Scenes/Environment/Tree.tscn")

onready var Map = get_node("/root/Map")
onready var elevation = get_node("/root/Map/World/Elevation")

var file : String = "res://Data/Maps/test_GroundLevel.csv"
var characters : Array
var ground = 4
var maindata

func _ready():
	load_csv_map_data(file)
	pass

func load_csv_map_data(file_path):
	maindata = []
	var f = File.new()
	var err = f.open(file, f.READ)
	if err != OK:
		return err
	while !f.eof_reached():
		var data_set = f.get_csv_line()
		maindata.append(data_set)
	f.close()
	print(maindata)
	create_map_array(maindata)

func create_map_array(text):
	#Set array
	characters = text
	#Array to map conversion
	if characters.size() > 0:
		for y in range(characters.size()):
			for x in range(characters[y].size()):
				get_tile_position(x, y)

func get_tile_position(x_pos, y_pos):	
	match characters[y_pos][x_pos]:
		"0":
			set_tile(x_pos, y_pos, ground)
		"213", "214", "215", "221", "222", "223", "229", "230", "231":
			set_tile(x_pos, y_pos, 1)
		"16", "17","18", "24", "25", "26", "32", "33", "34":
			set_tile(x_pos, y_pos, 0)
		"29":
			instance_scene(InteractiblePokeBall, "Pokeball", x_pos, y_pos)
		"21":
			instance_scene(TreeScene, "Tree", x_pos, y_pos)
	Map.update_bitmask_region()

func set_tile(x, y, tile : int):
	Map.set_cell(x + 1, y + 1, tile)

func instance_scene(scene, name, x, y):
	var newNode = Node2D.new()
	var newScene = scene.instance()
	newNode.name = name
	newNode.position = Vector2((x + 1) * 32, (y + 2) * 32)
	newNode.add_child(newScene)
	elevation.add_child(newNode)
