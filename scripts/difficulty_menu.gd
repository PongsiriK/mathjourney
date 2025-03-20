extends Control

@onready var camera = $Camera2D  # อ้างถึงกล้อง
@onready var anim_sprite = $AnimatedSprite2D  # อ้างถึง AnimatedSprite2D
@onready var easy_button = $HBoxContainer/Easy  # ปุ่ม Easy
@onready var color_rect = $ColorRect  # อ้างถึงจอดำ

func _ready() -> void:
	color_rect.modulate.a = 0  # เริ่มจากโปร่งใส

func _on_easy_pressed():
	print("✅ ปุ่ม EASY ถูกกด!")  
	play_zoom_animation()

func play_zoom_animation():
	print("🎬 เริ่มซูมไปที่ตัวละคร...")

	# ✅ สร้าง Tween
	var tween = create_tween()
	if not tween:
		print("⚠️ Tween เป็น null!")
		return

	# ✅ ซูมเข้าและเคลื่อนกล้องไปที่ตัวละคร
	tween.tween_property(camera, "global_transform:origin", anim_sprite.global_transform.origin, 1.0)
	tween.tween_property(camera, "zoom", Vector2(2, 2), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# ✅ ซูมเข้าเพิ่มอีก
	tween.tween_property(camera, "zoom", Vector2(1.5, 1.5), 0.5).set_delay(1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	await get_tree().create_timer(1).timeout
	# ✅ เริ่ม Fade จอดำ
	color_rect.visible = true  # เปิด ColorRect
	tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# ✅ รอให้ Fade เสร็จ
	await tween.finished

	# ✅ เปลี่ยนฉาก
	get_tree().change_scene_to_file("res://scenes/newmain.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
