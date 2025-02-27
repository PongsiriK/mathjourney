#extends Node2D
#
#
#var result
#var equation_label : Label
#var index_node = 1
#@onready var perent_node : Node2D = null
#@onready var child_node = [$"../Node2",$"../Node3",$"../Node4"]
#@onready var player = $Player
#
#var awswer_move =[]
#
#func _ready() -> void:
	##get_parent().current_node = get_node(self.node)
	#hide()
	#equation_label = $Label
	#generate_equation()
	#print($"../Node2".result)
	#
	#
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#
#func generate_equation() -> void:
	#var operator:Array = ["+", "-", "*", "/"]
	#var num1 = randi_range(-9, 9)
	#var num2 = randi_range(-9, 9)
	#var random_operator = randi_range(0, 3)
	#
	#match random_operator:
		#0:
			#result = num1 + num2
		#1:
			#result = num1 - num2
		#2:
			#result = num1 * num2
		#3:
			#while num2 == 0 or num1 % num2 != 0:
				#num2 = randi_range(-9, 9)
			#result = num1 / num2
	#
	#
	#equation_label.text = str(num1, " ", operator[random_operator], " ", num2, " = ?")
	#
#
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#
	#get_parent().current_node = name
	#
	#
	#get_parent().current_answers = [0, child_node[0].result ,child_node[1].result,child_node[2].result]
	#
	#
	#show()
	#equation_label.visible = false
	#for i in child_node :
		#i.show()
	#
#
#
#func _on_area_2d_body_exited(body: Node2D) -> void:
	#generate_equation()
	#equation_label.visible = true 
#func check_answer(new_text : String):
	#if new_text == str(perent_node.result):
		#move_player_to_node(perent_node)  # ย้ายไปยังโหนดแม่
	#if new_text == str(child_node[0].result):
		#move_player_to_node(child_node[0])  # ย้ายไปยังโหนดลูก 0
	#if new_text == str(child_node[1].result):
		#move_player_to_node(child_node[1])  # ย้ายไปยังโหนดลูก 1
	#if new_text == str(child_node[2].result):
		#move_player_to_node(child_node[2])
			#
#func move_player_to_node(target_node: Node2D) -> void:
	#player.position = target_node.position

extends Node2D

var result
var equation_label : Label
@onready var parent_node : Node2D = null  # โหนดแม่
@onready var child_node = [$"../Node2", $"../Node3", $"../Node4"]  # โหนดลูก
@onready var player = $Player  # ตัวละคร

var answer_move = []

# เริ่มต้น
func _ready() -> void:
	hide()  # ซ่อนโหนดในตอนแรก
	equation_label = $Label  # ตั้งค่าฉลากที่แสดงโจทย์
	generate_equation()  # สร้างโจทย์ทางคณิตศาสตร์
	print($"../Node2".result)  # ตรวจสอบคำตอบของโหนดลูก

# ฟังก์ชันสร้างโจทย์ทางคณิตศาสตร์
func generate_equation() -> void:
	var operator: Array = ["+", "-", "*", "/"]
	var num1 = randi_range(-9, 9)
	var num2 = randi_range(-9, 9)
	var random_operator = randi_range(0, 3)

	match random_operator:
		0:
			result = num1 + num2
		1:
			result = num1 - num2
		2:
			result = num1 * num2
		3:
			while num2 == 0 or num1 % num2 != 0:
				num2 = randi_range(-9, 9)
			result = num1 / num2

	equation_label.text = str(num1, " ", operator[random_operator], " ", num2, " = ?")

# ฟังก์ชันเมื่อมีการชนกับร่างกาย
func _on_area_2d_body_entered(body: Node2D) -> void:
	#get_parent().current_node = get_node(name)  # ตั้งค่าชื่อของโหนดเป็น current_node
	get_parent().current_answers = [result, child_node[0].result, child_node[1].result, child_node[2].result]
	
	show()  # แสดงโหนด
	equation_label.visible = false  # ซ่อนโจทย์
	for i in child_node:
		i.show()  # แสดงโหนดลูก

# ฟังก์ชันเมื่อร่างกายออกจากพื้นที่
func _on_area_2d_body_exited(body: Node2D) -> void:
	generate_equation()  # สร้างโจทย์ใหม่
	equation_label.visible = true  # แสดงโจทย์ใหม่

# ฟังก์ชันตรวจสอบคำตอบ
func check_answer(new_text : String):
	if new_text == str(parent_node.result):
		move_player_to_node(parent_node)  # ย้ายไปยังโหนดแม่
	elif new_text == str(child_node[0].result):
		move_player_to_node(child_node[0])  # ย้ายไปยังโหนดลูก 0
	elif new_text == str(child_node[1].result):
		move_player_to_node(child_node[1])  # ย้ายไปยังโหนดลูก 1
	elif new_text == str(child_node[2].result):
		move_player_to_node(child_node[2])  # ย้ายไปยังโหนดลูก 2

# ฟังก์ชันย้ายตัวละครไปยังโหนด
func move_player_to_node(target_node: Node2D) -> void:
	player.position = target_node.position
