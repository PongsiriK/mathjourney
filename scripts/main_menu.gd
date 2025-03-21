extends Control


func _ready() -> void:
	BGM.fade_out_and_change_bgm(BGM.bgm_main_menu)
		
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/difficulty_menu.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/option_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
