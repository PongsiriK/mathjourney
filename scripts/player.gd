#extends Node2D
#var cerrect_node = ""
## เคลื่อนที่ตัวละครไปยังตำแหน่งเป้าหมาย
#func move_to_position(target_position: Vector2) -> void:
	#position = target_position
extends Node2D

func _ready() -> void:
	position = get_viewport_rect().size / 2
#var current_node : Node2D  # โหนดที่ตัวละครยืนอยู่
#
#func _ready():
	#current_node = get_parent().current_node  # เริ่มที่โหนดแรก
#
#func move_to_node(next_node : Node2D):
	#position = cerrect_node.position  # ย้ายตัวละครไปยังโหนดลูก
