extends CanvasLayer

func _on_Pokedex_pressed():
	print("Pokedex pressed")

func _on_Pokemon_pressed():
	print("Pokemon pressed")

func _on_Bag_pressed():
	print("Bag pressed")

func _on_Player_pressed():
	print("Player pressed")

func _on_Save_pressed():
	print("Save pressed")

func _on_Option_pressed():
	print("Option pressed")

func _on_Exit_pressed():
	print("Quit pressed")
	get_tree().quit()
