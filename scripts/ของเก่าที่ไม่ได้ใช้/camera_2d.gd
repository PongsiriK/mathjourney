extends Camera2D

# ความเร็วในการแพนกล้อง
@export var pan_speed : float = 500.0 
@onready var player = $".."
func _process(delta: float) -> void:
	var move_vector = Vector2.ZERO
	
	# จับการกดปุ่มลูกศร
	if Input.is_action_pressed("ui_right"):
		move_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		move_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		move_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		move_vector.y -= 1
	if Input.is_action_pressed("ui_select"):
		global_position = player.global_position
	
	# เคลื่อนตำแหน่งกล้อง
	position += move_vector * pan_speed * delta
