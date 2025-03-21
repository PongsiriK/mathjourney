extends Control

func _ready():
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_graphic_button_pressed():
	get_tree().change_scene_to_file("res://scenes/graphic_settings.tscn")
