extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal get_the_key(body:Node2D,key:Node2D)

func _on_body_entered(body: Node2D) -> void:
	emit_signal("get_the_key",body,self)
