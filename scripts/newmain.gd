extends Node2D

var node_scene = preload("res://scenes/newnode.tscn")
var bridge_scence =  preload("res://scenes/rainbow.tscn")
#@onready var player = $Player
@onready var input_answer = $cameraOfMain/LineEdit
@onready var camera = $cameraOfMain
@onready var player = $CharacterBody2D
#var nodes = []
var max_depth = 4
var numOfNode = 0
var curent_node
var speed = 200

#func _process(delta: float) -> void:
func _process(delta: float) -> void:
	
	var direction = Vector2.ZERO

	if Input.is_action_pressed("up"):  # กด D
		direction.y -= 1
		
	if Input.is_action_pressed("down"):   # กด A
		direction.y += 1
		
	if Input.is_action_pressed("left"):   # กด S
		direction.x -= 1
	if Input.is_action_pressed("rigth"):     # กด W
		direction.x += 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()  # ป้องกันการเคลื่อนที่เร็วขึ้นเมื่อกดสองปุ่มพร้อมกัน

	
	player.position += direction * speed * delta
	


func _ready() -> void:
	
	### set start 
	var center_position = get_viewport_rect().size / 2  # จุดศูนย์กลางของหน้าจอ
	var radius = 250  # ระยะห่างจากจุดศูนย์กลาง
	 # เก็บตำแหน่งของโหนดทั้งหมด
	
	var start_node = node_scene.instantiate()
	start_node.connect("player_entered_area",_on_area_2d_body_exited)
	
	curent_node = start_node
	
	
	start_node.name = "Startnode"
	
	print(start_node.name , "IsMade")
	
	start_node.position = center_position
	#nodes.append(node_mom)
	numOfNode += 1
	add_child(start_node)
	var excluded_answers = []
	
	excluded_answers.append(random_equation(start_node,excluded_answers))
	start_node.show()
	
	
	for i in range(3):
		
		var node = node_scene.instantiate()
		node.connect("player_entered_area",_on_area_2d_body_entered)
		numOfNode += 1
		node.name = "node" + str(i+1)
		print(node.name , " IsMade")
		var angle_degree = 30 + (i * 120)
		var angle = deg_to_rad(30 + (i * 120))  # มุมแต่ละโหนด (0°, 120°, 240°)
		
		# คำนวณตำแหน่งโดยใช้ cos และ sin
		var x =  radius * cos(angle)
		var y =  radius * sin(angle)
		
		
		node.position = Vector2(x, y)  # ตั้งค่าตำแหน่งให้เป็นวงกลม
		start_node.add_child(node)
		
		excluded_answers.append(random_equation(node,excluded_answers))
		
		node.add_myParent(start_node)
		start_node.add_child_node(node)
		
		#nodes.append(node)
		create_bridge(start_node,node)
		#create_child_nodes(node, 30 + (i * 120))
		create_child_nodes(node, angle_degree, 1)
		
		
   # depth เริ่มที่ 1
	#print("Node have ", numOfNode)
	print(excluded_answers)

# ฟังก์ชันสร้างโหนดลูก
func create_child_nodes(parent_node: Node2D, parent_angle: float, depth: int) -> void:
	if depth >= max_depth:
		return  # หยุดเมื่อถึงระดับที่กำหนด

	var radius_node = 250 - (depth*20)  # ลดระยะห่างเมื่อระดับสูงขึ้น
	#var radius_node = 250 
	#var excluded_answers = []
	
	for i in range(2):
		#var angle_offset = -30 if i == 0 else 30
		var angle_offset = -30 + (90 * i)  # มุมที่กระจายออกจากโหนดแม่
		var angle_degree = parent_angle + angle_offset  # ให้แต่ละโหนดมีลูก 2 ตัว
		
		#var angle = parent_angle + deg_to_rad(-30 + (60 * i))  # มุมที่กระจายออก
		var angle = deg_to_rad(angle_degree )
		var child_node = node_scene.instantiate()
		child_node.connect("player_entered_area",_on_area_2d_body_entered)
		child_node.connect("player_exited_area",_on_area_2d_body_entered)
		numOfNode += 1
		child_node.name = parent_node.name + "|" + str(i+1)

		var x = radius_node * cos(angle)
		var y = radius_node * sin(angle)

		child_node.position = Vector2(x, y)
		parent_node.add_child(child_node)
		
		#excluded_answers.append(random_equation(child_node,excluded_answers))
		#print("ans of ", child_node.name , ": " , str(child_node.get_answer()))
		
		
		child_node.add_myParent(parent_node)
		parent_node.add_child_node(child_node)
		#nodes.append(child_node)
		create_bridge(parent_node, child_node)

		# สร้างโหนดลูกของ child_node (recursive)
		create_child_nodes(child_node, angle_degree , depth + 1)



func create_bridge(start_node: Node2D, end_node: Node2D) -> void:
	var start = Vector2.ZERO
	var end = end_node.position
	var bridge = bridge_scence.instantiate()
	bridge.name = start_node.name + "To" + end_node.name
	bridge.position = (start + end) / 2  # วางตรงกลางระหว่างสองจุด
	bridge.rotation = start.angle_to_point(end)  # หมุนให้ตรงกับแนวของสะพาน
	bridge.z_index = -1
	start_node.add_child(bridge)

func _on_area_2d_body_entered(node :Node2D,body: Node2D) -> void:	
	if body == player:
		curent_node = node
		print("Player เข้ามาในโหนด:", node.name )
		var pack_answer = []
		if node.get_parent_node() != null :
			print(pack_answer)
			pack_answer.append(random_equation(node.get_parent_node(),pack_answer))
			print("mom: ",node.get_parent_node().name)
		if node.get_Arraychild_nodes() != null :
			var i = 1
			for child in node.get_Arraychild_nodes() :
				print(pack_answer)
				pack_answer.append(random_equation(child,pack_answer))
				child.show()
				print("son",str(i),": ",child.name)
				i += 1
		if curent_node.get_answer() == null :
			print("no aws" )
		elif curent_node.get_answer() != null :
			print("aws= ", curent_node.get_answer())
			print("aws= ", curent_node.get_answer())
	
	
# ฟังก์ชันเมื่อร่างกายออกจากพื้นที่
func _on_area_2d_body_exited(node: Node2D,body: Node2D) -> void:
	pass
	
func move_player_to_node(target_node: Node2D) -> void:
	player.position = target_node.global_position
	
	var tween = create_tween()  # หยุด Tween ก่อนหน้า
	tween.tween_property(camera, "position", player.position, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#check_current_node()

func _on_line_edit_text_submitted(new_text: String) -> void:
	input_answer.text = ""
	
	
	#for node in nodes:
		#if check_answer_for_node(node, new_text):
			#print("Correct answer!")
			#return
	#print("Wrong answer!")
	#for node in nodes:
		#if node.has_method("get_answer"):  # ตรวจสอบว่าโหนดมีฟังก์ชัน get_answer()
			#if str(node.get_answer()) == new_text:  # ถ้าคำตอบตรงกัน
				#move_player_to_node(node)  # เคลื่อนที่ไปโหนดนั้น
				#return
#func check_answer_for_node(node: Node2D, answer: String) -> bool:
	## ตรวจสอบว่า answer ตรงกับชื่อโหนดแม่หรือโหนดลูก
	#pass


#func random_equation()-> String :
	#
	#var num1 = randi_range(-9, 9)
	##var num2 = 0
	#var num2 = randi_range(-9, 9)
	#var random_operator = randi_range(0, 3)
		#
	#match random_operator :
		#0:
			#answer = num1 + num2
		#1:
			#answer = num1 - num2
		#2:
			#answer = num1 * num2
		#3:	
			#while num2 == 0 or num1 % num2 != 0:  
				#num2 = randi_range(-9, 9)  # สุ่ม num2 ใหม่จนกว่าจะหารลงตัวและไม่เป็น 0
			#answer = num1 / num2
				#
	#
	#return  str(num1, " ", operator[random_operator]," ", num2, " = ?")

func random_equation(nodeSetAnswer : Node2D ,excluded_answers: Array ) -> int:
	var operator:Array = ["+","-","*","/"]
	var num1: int
	var num2: int
	var random_operator: int
	var new_answer: int

	while new_answer in excluded_answers:
		num1 = randi_range(-9, 9)
		num2 = randi_range(-9, 9)
		random_operator = randi_range(0, 3)

		match random_operator:
			0:
				new_answer = num1 + num2
			1:
				new_answer = num1 - num2
			2:
				new_answer = num1 * num2
			3:
				while num2 == 0 or num1 % num2 != 0:
					num2 = randi_range(-9, 9)
				new_answer = num1 / num2

		# ถ้าคำตอบที่สุ่มได้ไม่อยู่ใน excluded_answers ให้ใช้คำตอบนี้
		if not new_answer in excluded_answers:
			nodeSetAnswer.set_answer(new_answer)
			nodeSetAnswer.set_equation(str(num1, " ", operator[random_operator], " ", num2, " = ?"))
	return new_answer
	
