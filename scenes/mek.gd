extends Sprite2D

var s = 1000
var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	position.x += s * delta
	
	# ถ้าหลุดจอทางขวา ให้ย้ายกลับมาเริ่มที่ด้านซ้าย
	if position.x > screen_size.x:
		position.x = -texture.get_width()
