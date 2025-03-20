extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size / 2
	hide()
	monitoring = false

signal entered_the_door(body :Node2D)

func _on_body_entered(body: Node2D) -> void:
		emit_signal("entered_the_door",body)
