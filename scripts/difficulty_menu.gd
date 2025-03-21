extends Control

@onready var camera = $Camera2D
@onready var anim_sprite = $AnimatedSprite2D
@onready var easy_button = $HBoxContainer/Easy
@onready var color_rect = $ColorRect

var bgm_player: AudioStreamPlayer  # ประกาศตัวแปรเพื่อเก็บ AudioStreamPlayer
var easy_description_image : Sprite2D  # สร้างตัวแปรสำหรับเก็บ Sprite
var medium_description_image : Sprite2D
var hard_description_image : Sprite2D

func _ready() -> void:
	color_rect.modulate.a = 0
	easy_description_image = $HBoxContainer3/Easy_describe
	easy_description_image.visible = false  # ซ่อนภาพเมื่อเริ่มต้น
	medium_description_image = $HBoxContainer4/Medium_describe
	medium_description_image.visible = false  # ซ่อนภาพเมื่อเริ่มต้น
	hard_description_image = $HBoxContainer5/Hard_describe
	hard_description_image.visible = false  # ซ่อนภาพเมื่อเริ่มต้น

func _on_easy_pressed():
	print("✅ ปุ่ม EASY ถูกกด!") 
	play_zoom_animation()

func play_zoom_animation():
	print("🎬 เริ่มซูมไปที่ตัวละคร...")

	var tween = create_tween()
	if not tween:
		print("⚠️ Tween เป็น null!")
		return

	tween.tween_property(camera, "global_transform:origin", anim_sprite.global_transform.origin, 1.0)
	tween.tween_property(camera, "zoom", Vector2(2, 2), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(camera, "zoom", Vector2(1.5, 1.5), 0.5).set_delay(1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	await get_tree().create_timer(1).timeout

	$Transition_SFX.play()

	color_rect.visible = true
	tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	BGM.fade_out_and_change_bgm(BGM.bgm_gameplay)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/newmain.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# เมื่อ mouse hover ที่ปุ่ม Easy
func _on_easy_mouse_entered():
	easy_description_image.visible = true  # แสดงภาพเมื่อ hover

# เมื่อ mouse ออกจากปุ่ม Easy
func _on_easy_mouse_exited():
	easy_description_image.visible = false  # ซ่อนภาพเมื่อไม่ hover


func _on_medium_mouse_entered() -> void:
	medium_description_image.visible = true


func _on_medium_mouse_exited() -> void:
	medium_description_image.visible = false


func _on_hard_mouse_entered() -> void:
	hard_description_image.visible = true


func _on_hard_mouse_exited() -> void:
	hard_description_image.visible = false
