extends Node2D
@onready var label = $"../Player/Camera2D/Label"
var key = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_area_2d_body_entered(body: Node2D) -> void:
	hide()
	key += 1
	label.text = str(key)
	# Replace with function body.
