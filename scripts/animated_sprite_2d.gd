extends AnimatedSprite2D

var rotation_speed = 0.5  # ความเร็วในการหมุน (ค่าตั้งต้น)
var direction = 1  # ทิศทางการหมุน

func _ready():
	play("idle")  # เล่นแอนิเมชัน
	randomize_rotation()  # กำหนดการหมุนแบบสุ่ม

func _process(delta):
	rotation += direction * rotation_speed * delta  # หมุนตัวละคร

func randomize_rotation():
	var tween = get_tree().create_tween()  # สร้าง Tween
	var new_speed = randf_range(0.1, 0.5)  # สุ่มค่าความเร็ว
	direction = 1 if randi() % 2 == 0 else -1  # สุ่มทิศทาง
	tween.tween_property(self, "rotation_speed", new_speed, 2.0)  # เปลี่ยนความเร็วแบบ smooth
	tween.tween_callback(randomize_rotation)  # ทำซ้ำเมื่อ Tween จบ
