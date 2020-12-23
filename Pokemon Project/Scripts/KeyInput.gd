extends Node

onready var menu = get_node("/root/Map/GUI/Menu")
onready var pokedex = get_node("/root/Map/GUI/Menu/Content/Pokedex")
onready var player = get_node("/root/Map/World/Elevation/Player")

func _process(delta):
	if Input.is_action_just_pressed("ui_menu"):
		menu.visible = !menu.visible
		pokedex.grab_focus()
		if menu.visible:
			player.can_move = false
		else:
			player.can_move = true
