extends NinePatchRect

onready var arrow = $Arrow
onready var pokedex = $Content/Pokedex
onready var pokemon = $Content/Pokemon
onready var bag = $Content/Bag
onready var player = $Content/Player
onready var save = $Content/Save
onready var option = $Content/Option
onready var exit = $Content/Exit

var pad = 13

func _on_Pokedex_focus_entered():
	arrow.position.y = pokedex.rect_position.y + pad

func _on_Pokemon_focus_entered():
	arrow.position.y = pokemon.rect_position.y + pad

func _on_Bag_focus_entered():
	arrow.position.y = bag.rect_position.y + pad

func _on_Player_focus_entered():
	arrow.position.y = player.rect_position.y + pad

func _on_Save_focus_entered():
	arrow.position.y = save.rect_position.y + pad

func _on_Option_focus_entered():
	arrow.position.y = option.rect_position.y + pad

func _on_Exit_focus_entered():
	arrow.position.y = exit.rect_position.y + pad
