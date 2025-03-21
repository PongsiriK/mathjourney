extends Control

@onready var back_button = $HBoxContainer2/Back
@onready var option_button = $HBoxContainer/OptionButton

const WINDOW_MODE_ARRAY : Array[String] = [
	"Fullscreen",
	"Windowed",
	"Borderless Windowed",
	"Borderless Fullscreen"
]

func _ready():
	add_window_mode_items()
	option_button.item_selected.connect(_on_window_mode_selected)
	

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_audio_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/audio_settings.tscn")


func add_window_mode_items() -> void:
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)


func _on_window_mode_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
