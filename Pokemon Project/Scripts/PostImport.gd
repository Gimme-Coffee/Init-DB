extends Node

var my_node = load("res://my_scene.tscn")

func post_import(scene):
	var new_node = my_node.instance()
	new_node.set_owner(scene)
	scene.add_child(new_node)
	return scene
