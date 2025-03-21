extends Camera2D

@onready var player = $"../CharacterBody2D"
@onready var box_answer = $LineEdit
@export var speed: float = 300  # ความเร็วในการเลื่อน (พิกเซลต่อวินาที)


func _ready() -> void:
	position = get_viewport_rect().size / 2
	#limit_left = 0
	#limit_right = 1920
	#limit_top = 0
	#limit_bottom = 1080
	#box_answer.position = get_viewport_rect().size / 2
	
func _process(delta: float) -> void:
	var move_direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		if position.x < 2200 :
			move_direction.x += 1
		
	if Input.is_action_pressed("ui_left"):
		if position.x > - 400 :
			move_direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		if position.y < 1700 :
			move_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		if position.y > - 900 :
			move_direction.y -= 1
		
	if Input.is_action_pressed("ui_select"):
		#position = player.position
		#position = position.lerp(player.position, 5 * delta) 
		var tween = create_tween()  # หยุด Tween ก่อนหน้า
		tween.tween_property(self, "position", player.position, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# ปรับตำแหน่งของกล้อง
	position += move_direction.normalized() * speed * delta
