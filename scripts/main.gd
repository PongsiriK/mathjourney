extends Node2D

var current_node 
var current_answers = [0,0,0,0]
var input 
#var position_player =  $Player.position
#var position_move = 

func _ready():
	print(current_node)

func _process(delta: float) -> void:
	print(current_node)
	print(current_answers[0],current_answers[1],current_answers[2],current_answers[3])
	

#func _on_input_box_text_submitted(new_text: String) -> void:
	#for i in current_answers :
		#if int(new_text) == current_answers[i] :
			#move_to_node(i)
#
#func move_to_node(node : int):
	#pass
#extends Node2D
#
#@onready var player = $Player  # ตัวละครหลัก
#@onready var camera = $Camera2D  # กล้อง
#@onready var nodes_container = $Nodes  # โหนดทั้งหมดอยู่ใน Container นี้
#@onready var answer_input = $Control/LineEdit  # ช่องรับคำตอบจากผู้เล่น
#
## เก็บโหนดทั้งหมดในเกม (node1, node2, ... node40)
#var all_nodes = []
#
#func _ready() -> void:
	## เพิ่มโหนดทั้งหมดเข้าไปในอาร์เรย์
	#for node in nodes_container.get_children():
		#all_nodes.append(node)
	#
	## ตั้งค่าตัวละครเริ่มต้นที่โหนดแรก
	#move_player_to_node(all_nodes[0])
#
#func _process(delta: float) -> void:
	## เคลื่อนกล้องตามตัวละคร
	#camera.position = player.position
	#
	## การเลื่อนกล้องด้วยลูกศร
	#if Input.is_action_pressed("ui_right"):
		#camera.position.x += 200 * delta
	#elif Input.is_action_pressed("ui_left"):
		#camera.position.x -= 200 * delta
	#elif Input.is_action_pressed("ui_up"):
		#camera.position.y -= 200 * delta
	#elif Input.is_action_pressed("ui_down"):
		#camera.position.y += 200 * delta
#
#func _input(event: InputEvent) -> void:
	## รีเซ็ตกล้องกลับมาที่ตัวละครเมื่อกด Spacebar
	#if event.is_action_pressed("ui_accept"):
		#camera.position = player.position
#
## รับคำตอบจากผู้เล่น
#func _on_LineEdit_text_submitted(answer: String) -> void:
	#var current_node = get_current_node()
	#if current_node and current_node.result == int(answer):
		#print("Correct Answer!")
		#move_player_to_node(current_node.child_nodes[0])  # ย้ายไปยังโหนดลูก (ตัวอย่าง)
	#else:
		#print("Wrong Answer!")
#
## ฟังก์ชันย้ายตัวละครไปยังโหนดที่ต้องการ
#func move_player_to_node(target_node: Node2D) -> void:
	#player.position = target_node.position
#
## ฟังก์ชันดึงโหนดปัจจุบันที่ผู้เล่นยืนอยู่
#func get_current_node() -> Node2D:
	#for node in all_nodes:
		#if player.position.distance_to(node.position) < 10:
			#return node
	#return null
