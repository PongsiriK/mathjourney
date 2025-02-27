#extends Node2D
#
#@onready var current_node = $Node1
#var current_answers = [0, 0, 0, 0]
#var input
#@onready var player = $Player
#var target_node 
#
#func _ready():
	#print(current_node)
	#
##func _process(delta: float) -> void:
	##print(current_node)
	##print(current_answers[0], current_answers[1], current_answers[2], current_answers[3])
#
## เมื่อกรอกข้อความใหม่
#func _on_input_box_text_submitted(new_text: String) -> void:
	## ตรวจสอบคำตอบและย้ายตัวละคร
	##pass
	#$Player/Camera2D/InputBox.text = ""
	##target_node = get_node(current_node)
	#target_node = current_node
	##current_node.check_answer(new_text)  # อ้างอิงไปยังโหนดปัจจุบัน
	#if new_text == str(current_answers[0]):
		#move_player_to_node(target_node.parent)  # ย้ายไปยังโหนดแม่
	#if new_text == str(current_answers[1]):
		#move_player_to_node(target_node.child_node[0])  # ย้ายไปยังโหนดลูก 0
	#if new_text == str(current_answers[2]):
		#move_player_to_node(target_node.child_node[1])  # ย้ายไปยังโหนดลูก 1
	#if new_text == str(current_answers[3]):
		#move_player_to_node(target_node.child_node[2])  # ย้ายไปยังโหนดลูก 2
#
## ฟังก์ชันย้ายตัวละครไปยังโหนด
#func move_player_to_node(target_node: Node2D) -> void:
	#player.position = target_node.position
	#current_node = target_node

extends Node2D

@onready var current_node : Node2D = $Node1  # โหนดปัจจุบันที่ตัวละครยืนอยู่
var current_answers = [0, 0, 0, 0]  # คำตอบที่เช็คกับอินพุต
@onready var player : Node2D = $Player  # ตัวละครที่เราต้องการเคลื่อนที่
var target_node : Node2D

# เริ่มต้น
func _ready():
	print(current_node)

# เมื่อกรอกข้อความใหม่
func _on_input_box_text_submitted(new_text: String) -> void:
	# ลบข้อความใน InputBox หลังจากส่งข้อมูล
	$Player/Camera2D/InputBox.text = ""
	
	# เช็คคำตอบ
	target_node = current_node  # ตั้งค่าโหนดที่ตัวละครยืนอยู่เป็น target_node
	if new_text == str(current_answers[0]):
		move_player_to_node(target_node.parent_node)  # ย้ายไปยังโหนดแม่
	elif new_text == str(current_answers[1]):
		move_player_to_node(target_node.child_node[0])  # ย้ายไปยังโหนดลูก 0
	elif new_text == str(current_answers[2]):
		move_player_to_node(target_node.child_node[1])  # ย้ายไปยังโหนดลูก 1
	elif new_text == str(current_answers[3]):
		move_player_to_node(target_node.child_node[2])  # ย้ายไปยังโหนดลูก 2

# ฟังก์ชันย้ายตัวละครไปยังโหนดที่เลือก
func move_player_to_node(target_node: Node2D) -> void:
	player.position = target_node.position
	current_node = target_node  # เปลี่ยนโหนดที่ตัวละครยืนอยู่เป็นโหนดที่ย้ายไป
