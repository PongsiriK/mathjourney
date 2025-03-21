extends Node

@onready var bgm_player: AudioStreamPlayer = AudioStreamPlayer.new()

var bgm_main_menu: AudioStream = preload("res://assets/bgm_main_menu.mp3")
var bgm_gameplay: AudioStream = preload("res://assets/bgm_easy.mp3")

func _ready():
	add_child(bgm_player)
	bgm_player.stream = bgm_main_menu
	bgm_player.volume_db = -10  # เสียงเริ่มต้น
	bgm_player.play()

# ✅ ฟังก์ชันลดเสียงเพลงลงก่อนเปลี่ยนเพลง
func fade_out_and_change_bgm(new_bgm: AudioStream):
	var tween = create_tween()
	tween.tween_property(bgm_player, "volume_db", -40, 1.5).set_trans(Tween.TRANS_SINE)
	await tween.finished  # รอให้ fade out เสร็จ
	
	change_bgm(new_bgm)

# ✅ ฟังก์ชันเปลี่ยนเพลงแล้วค่อยๆ เพิ่มเสียงกลับมา
func change_bgm(new_bgm: AudioStream):
	if bgm_player.stream == new_bgm:
		return
	
	bgm_player.stop()
	bgm_player.stream = new_bgm
	bgm_player.play()
	
	# ✅ ทำ fade in เสียงใหม่
	var tween = create_tween()
	bgm_player.volume_db = -40  # ตั้งค่าเสียงให้เบาสุดก่อน
	tween.tween_property(bgm_player, "volume_db", -10, 1.5).set_trans(Tween.TRANS_SINE)
