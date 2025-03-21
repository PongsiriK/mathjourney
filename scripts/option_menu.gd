extends Control

@onready var graphic_button = $VBoxContainer2/GraphicButton
@onready var audio_button = $VBoxContainer/AudioButton
@onready var back_button = $HBoxContainer2/Back

func _ready():
	#graphic_button.pressed.connect(_on_graphic_button_pressed)
	audio_button.pressed.connect(_on_audio_pressed)
	#back_button.pressed.connect(_on_back_pressed)

func _on_audio_pressed():
	get_tree().change_scene_to_file("res://scenes/audio_settings.tscn")
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_graphic_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/graphic_settings.tscn")
