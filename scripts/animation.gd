extends AnimatedSprite2D

func _ready():
	position.y = -1000
	play("start")  # เล่นอนิเมชั่น jump ขณะเคลื่อนที่
	var tween = create_tween()
	tween.tween_property(self, "position:y", -100, 1.5).set_ease(Tween.EASE_OUT )
	await tween.finished
	stop()
	play("stand")
