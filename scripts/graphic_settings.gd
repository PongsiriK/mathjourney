extends Control

#@onready var screen_type_label = $VBoxContainer3/ScreenTypeLabel
#@onready var vsync_button = $VBoxContainer3/VSyncButton
@onready var back_button = $HBoxContainer2/Back

var screen_modes = ["Windowed", "Fullscreen", "Windowed Fullscreen"]
var screen_index = 1  # เริ่มต้นเป็น Fullscreen
var vsync_enabled = true

#func _ready():
	#_update_labels()
#
#func _input(event):
	#if event.is_action_pressed("ui_left"):
		#screen_index = (screen_index - 1) % screen_modes.size()
		#_update_labels()
	#elif event.is_action_pressed("ui_right"):
		#screen_index = (screen_index + 1) % screen_modes.size()
		#_update_labels()
	#elif event.is_action_pressed("ui_accept"):  # Enter เพื่อยืนยันการเปลี่ยน
		#_apply_screen_mode()
#
#func _on_vsync_pressed():
	#vsync_enabled = !vsync_enabled
	#DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if vsync_enabled else DisplayServer.VSYNC_DISABLED)
	#_update_labels()
#
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
#
#func _apply_screen_mode():
	#match screen_modes[screen_index]:
		#"Windowed":
			#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#"Fullscreen":
			#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		#"Windowed Fullscreen":
			#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
#
#func _update_labels():
	#screen_type_label.text = "Screen Type: < " + screen_modes[screen_index] + " >"
	#vsync_button.text = "V-Sync: " + ("Enabled" if vsync_enabled else "Disabled")


func _on_audio_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/audio_settings.tscn")
