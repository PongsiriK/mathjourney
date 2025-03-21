extends Control


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/OptionsMenu.tscn")


func _on_graphic_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/graphic_settings.tscn")
