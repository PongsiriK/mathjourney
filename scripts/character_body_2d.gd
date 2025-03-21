extends CharacterBody2D

@onready var animation = $animation
#var is_jumping = false

func _ready() -> void:
	position = get_viewport_rect().size / 2
	# กำหนดให้ภาพเริ่มต้นอยู่นอกจอด้านบน
	
	
	#animation.get_animation("jump").loop = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		play_jump_L()
	if Input.is_action_just_pressed("ui_right"):
		play_jump_R()
	#if Input.is_action_just_pressed("ui_down"):
		#animation.play("stand")
func play_jump_L():
	animation.flip_h = true
	animation.position.x = 50
	animation.play("jump")
	await animation.animation_finished
	animation.play("stand")

func play_jump():
	
	animation.play("jump")
	await animation.animation_finished
	animation.play("stand")
	
func play_jump_R():
	animation.flip_h = false
	animation.position.x = -50
	animation.play("jump")
	await animation.animation_finished
	animation.play("stand")

func wrong():
	animation.play("wrong2")
	await animation.animation_finished
	animation.play("stand")

func yeah():
	animation.play("yeah")
	await animation.animation_finished
	animation.play("stand")
