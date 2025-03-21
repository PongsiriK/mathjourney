extends Node

var click_sound = preload("res://assets/SFX/Click_sound.mp3")
var click_player: AudioStreamPlayer  # ✅ แยก AudioStreamPlayer ของเสียงคลิก

func _ready():
	click_player = AudioStreamPlayer.new()
	click_player.stream = click_sound
	click_player.bus = "SFX"  # ✅ ใช้ Audio Bus "SFX" แยกจาก BGM
	add_child(click_player)
	
	# ✅ เชื่อมกับ Input เพื่อให้เล่นเสียงอัตโนมัติเมื่อมีการคลิกปุ่ม
	Input.connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		play_click_sound()

func play_click_sound():
	if not click_player.playing:  # ✅ ป้องกันเสียงซ้อน
		click_player.play()
