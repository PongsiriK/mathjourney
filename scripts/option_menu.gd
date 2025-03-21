extends Control

@onready var graphic_button = $VBoxContainer2/GraphicButton
@onready var audio_button = $VBoxContainer/AudioButton
@onready var back_button = $HBoxContainer2/Back

func _ready():
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_graphic_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/graphic_settings.tscn")


func _on_audio_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/audio_settings.tscn")
