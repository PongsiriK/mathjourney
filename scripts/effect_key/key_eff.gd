extends Sprite2D


var float_speed = 4.0      # ความเร็วในการลอย
var float_height = 0.4    # ระยะการลอยขึ้นลง
#var start_position = Vector2.ZERO
#
#func _ready():
	#start_position = position

func _process(delta):
	position.y = position.y + sin(Time.get_ticks_msec() / 1000.0 * float_speed) * float_height
