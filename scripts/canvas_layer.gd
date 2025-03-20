extends CanvasLayer

#@onready var anim_sprite = $"../AnimatedSprite2D"  # อ้างถึง AnimatedSprite2D
#@onready var color_rect = $ColorRect  # อ้างถึงจอดำ
#
#func play_transition():
	#var tween = get_tree().create_tween()
#
	## 1️⃣ ซูมกล้องไปที่ AnimatedSprite2D
	#var camera = get_viewport().get_camera_2d()
	#tween.tween_property(camera, "zoom", Vector2(2, 2), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(camera, "position", anim_sprite.position, 1.0)
#
	## 2️⃣ หน่วงเวลาแล้ว Fade Out
	#await get_tree().create_timer(1.0).timeout
	#color_rect.visible = true  # แสดงจอดำ
	#tween.tween_property(color_rect, "modulate:a", 1.0, 0.8).set_trans(Tween.TRANS_SINE)
#
	## 3️⃣ เปลี่ยนฉากหลังจากจอดำ
	#await get_tree().create_timer(0.8).timeout
	#get_tree().change_scene_to_file("res://scenes/newmain.tscn")  # เปลี่ยนไปหน้าเกม
