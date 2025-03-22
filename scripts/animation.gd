extends AnimatedSprite2D


func _ready():
	$"../StartBubble".hide()
	$"../WrongAnswerBubble".hide()
	position.y = -1000
	$"../fall".play()
	play("start")  # เล่นอนิเมชั่น jump ขณะเคลื่อนที่
	var tween = create_tween()
	tween.tween_property(self, "position:y", -100, 1.5).set_ease(Tween.EASE_OUT )
	await tween.finished
	stop()
	
	play("stand")
	$"../WrongAnswerBubble".show()
	await wait(3)
	$"../WrongAnswerBubble".hide()

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
