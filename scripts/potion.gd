extends Area2D





signal get_potion(body:Node2D,potion:Node2D)

func _on_body_entered(body: Node2D) -> void:
	emit_signal("get_potion",body,self)
