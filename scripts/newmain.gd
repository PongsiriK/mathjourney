extends Node2D

var node_scene = preload("res://scenes/newnode.tscn")
var bridge_scence =  preload("res://scenes/rainbow.tscn")
var potion_scene = preload("res://scenes/potion.tscn")
var key_scene = preload("res://scenes/key.tscn")
#@onready var player = $Player
@onready var input_answer = $cameraOfMain/LineEdit
@onready var camera = $cameraOfMain
@onready var player = $CharacterBody2D
@onready var door = $door

#var nodes = []
var max_depth = 4
#var numOfNode = 0
var curent_node
var speed = 500
var checkAnswer = []

var node_pack = []
var node_pack_no1 = []
var node_pack_no2 = []
var node_pack_no3 = []
var node_pack_no4 = []

var node_random_key1 = []
var node_random_key2 = []
var node_random_key3 = []

var key_node = []
var potion_node = []

var nodes_random = []



#func _process(delta: float) -> void:
func _process(delta: float) -> void:
	
	var direction = Vector2.ZERO

	if Input.is_action_pressed("up"):  # กด D
		direction.y -= 1
		used_mana(1)
		
	if Input.is_action_pressed("down"):   # กด A
		direction.y += 1
		
	if Input.is_action_pressed("left"):   # กด S
		direction.x -= 1
	if Input.is_action_pressed("rigth"):     # กด W
		direction.x += 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()  # ป้องกันการเคลื่อนที่เร็วขึ้นเมื่อกดสองปุ่มพร้อมกัน

	
	player.position += direction * speed * delta
	print(current_health)


func _ready() -> void:
	
	### set start 
	var center_position = get_viewport_rect().size / 2  # จุดศูนย์กลางของหน้าจอ
	var radius = 250  # ระยะห่างจากจุดศูนย์กลาง
	 # เก็บตำแหน่งของโหนดทั้งหมด
	
	var start_node = node_scene.instantiate()
	
	
	door.connect("entered_the_door",body_entered_thedoor)
	
	curent_node = start_node
	
	
	start_node.name = "Startnode"
	
	
	
	start_node.position = center_position
	#nodes.append(node_mom)
	
	add_child(start_node)
	
	node_pack.append(start_node)
	
	
	
	#start_node.show()
	start_node.connect("player_entered_area",_on_area_2d_body_entered)
	start_node.connect("player_exited_area",_on_area_2d_body_exited)
	
	
	var excluded_answers = []
	random_equation(start_node,excluded_answers)
	
	for i in range(3):
		
		var node = node_scene.instantiate()
		node.connect("player_entered_area",_on_area_2d_body_entered)
		node.connect("player_exited_area",_on_area_2d_body_exited)
		
		node.name = "node" + str(i+1)
		
		var angle_degree = 30 + (i * 120)
		var angle = deg_to_rad(30 + (i * 120))  # มุมแต่ละโหนด (0°, 120°, 240°)
		
		# คำนวณตำแหน่งโดยใช้ cos และ sin
		var x =  radius * cos(angle)
		var y =  radius * sin(angle)
		
		
		node.position = Vector2(x, y)  # ตั้งค่าตำแหน่งให้เป็นวงกลม
		start_node.add_child(node)
		node.add_myParent(start_node)
		start_node.add_child_node(node)
		
		node_pack.append(node)
		
		random_equation(node,excluded_answers)
		
		
		
		#nodes.append(node)
		create_bridge(start_node,node)
		#create_child_nodes(node, 30 + (i * 120))
		
		
		match i + 1:
			1:
				create_child_nodes(node, angle_degree, 1 ,1)
			2:
				create_child_nodes(node, angle_degree, 1, 2)
			3:
				create_child_nodes(node, angle_degree, 1 ,3)
		
	
	
	node_show(start_node)
	#set_pos_key(node_pack_no1)
	#set_pos_key(node_pack_no2)
	#set_pos_key(node_pack_no3)
	print("before ",node_random_key1.size())
	print(node_random_key1)
	set_pos_key(node_random_key1)
	print("after ",node_random_key1.size())
	print(node_random_key1)
	
	set_pos_key(node_random_key2)
	set_pos_key(node_random_key3)
	
   # depth เริ่มที่ 1
	#print("Node have ", numOfNode)
	#print(node_pack.size())
	#print(node_pack_no1.size())
	#print(node_pack_no2.size())
	#print(node_pack_no3.size())
	#print(node_pack_no1 ,"\n")
	#print(node_pack_no2,"\n")
	#print(node_pack_no3,"\n")
	
	nodes_random = node_pack_no1 + node_pack_no2 + node_pack_no3
	
	print("before ",nodes_random.size())
	print(nodes_random)
	create_potion(5)
	print("after ",nodes_random.size())
	print(nodes_random)
	print("===========================================================")
	print(key_node)
	print("===========================================================")
	print(potion_node)
# ฟังก์ชันสร้างโหนดลูก
func create_child_nodes(parent_node: Node2D, parent_angle: float, depth: int , group: int) -> void:
	#if depth == max_depth - 1 :
		#print
	if depth >= max_depth:
		
		#print(parent_node)
		match group:
			1:
				node_random_key1.append(parent_node)
			2:
				node_random_key2.append(parent_node)
			3:
				node_random_key3.append(parent_node)
		return  # หยุดเมื่อถึงระดับที่กำหนด
	
	
		
	
	
	var radius_node = 250 - (depth*20)  # ลดระยะห่างเมื่อระดับสูงขึ้น
	#var radius_node = 250 
	#var excluded_answers = []
	var ex_answers = []
	ex_answers.append(parent_node)
	for i in range(2):
		#var angle_offset = -30 if i == 0 else 30
		var angle_offset = -30 + (90 * i)  # มุมที่กระจายออกจากโหนดแม่
		var angle_degree = parent_angle + angle_offset  # ให้แต่ละโหนดมีลูก 2 ตัว
		
		#var angle = parent_angle + deg_to_rad(-30 + (60 * i))  # มุมที่กระจายออก
		var angle = deg_to_rad(angle_degree )
		var child_node = node_scene.instantiate()
		child_node.connect("player_entered_area",_on_area_2d_body_entered)
		child_node.connect("player_exited_area",_on_area_2d_body_exited)
		
		child_node.name = parent_node.name + "|" + str(i+1)

		var x = radius_node * cos(angle)
		var y = radius_node * sin(angle)

		child_node.position = Vector2(x, y)
		parent_node.add_child(child_node)
		
		node_pack.append(child_node)
		
		random_equation(child_node,ex_answers)
		#excluded_answers.append(random_equation(child_node,excluded_answers))
		#print("ans of ", child_node.name , ": " , str(child_node.get_answer()))
		
		
		child_node.add_myParent(parent_node)
		parent_node.add_child_node(child_node)
		#nodes.append(child_node)
		create_bridge(parent_node, child_node)
		
		match group:
			1:
				node_pack_no1.append(child_node)
				node_pack_no4.append(child_node)
				create_child_nodes(child_node, angle_degree , depth + 1 , 1)
			2:
				node_pack_no2.append(child_node)
				node_pack_no4.append(child_node)
				create_child_nodes(child_node, angle_degree , depth + 1 , 2)
			3:
				node_pack_no3.append(child_node)
				node_pack_no4.append(child_node)
				create_child_nodes(child_node, angle_degree , depth + 1 , 3)

		# สร้างโหนดลูกของ child_node (recursive)
		#create_child_nodes(child_node, angle_degree , depth + 1 )



func create_bridge(start_node: Node2D, end_node: Node2D) -> void:
	var start = Vector2.ZERO
	var end = end_node.position
	var bridge = bridge_scence.instantiate()
	bridge.name = start_node.name + "To" + end_node.name
	bridge.position = (start + end) / 2  # วางตรงกลางระหว่างสองจุด
	bridge.rotation = start.angle_to_point(end)  # หมุนให้ตรงกับแนวของสะพาน
	bridge.z_index = -1
	start_node.add_child(bridge)
	start_node.add_connect_node(bridge)

func _on_area_2d_body_entered(node :Node2D,body: Node2D) -> void:	
	if body == player:
		checkAnswer = []
		curent_node = node
		node_show(node)
		node.hide_equation()
		
		#print("Player เข้ามาในโหนด:", node.name )
		#var pack_answer = []
		if node.get_parent_node() != null :
			checkAnswer.append(node.get_parent_node().get_answer())
			##print(pack_answer)
			##pack_answer.append(random_equation(node.get_parent_node(),pack_answer))
			#print("mom: ",node.get_parent_node().name)
		if node.get_Arraychild_nodes() != null :
			#var i = 1
			for child in node.get_Arraychild_nodes() :
				checkAnswer.append(child.get_answer())
				##print(pack_answer)
				##pack_answer.append(random_equation(child,pack_answer))
				#print("son",str(i),": ",child.name)
				#i += 1
		#print(checkAnswer)
		#if curent_node.get_answer() == null :
			#print("no aws" )
		#elif curent_node.get_answer() != null :
			#print("aws= ", curent_node.get_answer())
		
	
	
# ฟังก์ชันเมื่อร่างกายออกจากพื้นที่
func _on_area_2d_body_exited(node: Node2D,body: Node2D) -> void:
	#print("ออกไปล้วจ๊าลาก่อน " ,node.name)
	if body == player :
		var pack_answer = []
		if node.get_parent_node() != null :
			pack_answer.append(node.get_parent_node().get_answer())
		if node.get_Arraychild_nodes() != null :
			for child in node.get_Arraychild_nodes() :
				pack_answer.append(child)
			random_equation(node,pack_answer)
	
	
	
	
func move_player_to_node(target_node: Node2D) -> void:
	player.position = target_node.global_position
	
	var tween = create_tween()  # หยุด Tween ก่อนหน้า
	tween.tween_property(camera, "position", player.position, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#check_current_node()

func _on_line_edit_text_submitted(new_text: String) -> void:
	input_answer.text = ""
	#print("ans ",new_text)
	
	var pack_answer = []
	if curent_node.get_parent_node()!= null :
		pack_answer.append(curent_node.get_parent_node().get_answer())
		if new_text.strip_edges() == str(curent_node.get_parent_node().get_answer()):
			move_player_to_node(curent_node.get_parent_node())
			
	if curent_node.get_Arraychild_nodes() != null :
		for child in curent_node.get_Arraychild_nodes() :
				pack_answer.append(child.get_answer())
				if new_text.strip_edges() == str(child.get_answer()) :
					move_player_to_node(child)
					
	#print(pack_answer)

func random_equation(nodeSetAnswer : Node2D ,excluded_answers: Array ) -> int:
	var operator:Array = ["+","-","×","÷"]
	var num1: int
	var num1str : String
	var num2: int
	var num2str : String
	var random_operator: int
	var new_answer: int
	#nodeSetAnswer.show_equation()
	while true :
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
					#if num2 < 0 :
						#num2str = "(" + str(num2) +  ")"
				new_answer = num1 / num2
			
		if num1 < 0 :
			num1str = "(" + str(num1) +  ")"
		
		if num2 < 0 :
			num2str = "(" + str(num2) +  ")"
		
		if num1 >= 0 :
			num1str = str(num1)
		
		if num2 >= 0 :
			num2str = str(num2)
		
		#if excluded_answers.size() == 0 : 
			#nodeSetAnswer.set_answer(new_answer)
			#nodeSetAnswer.set_equation(str(num1, " ", operator[random_operator], " ", num2, " = ?"))
		# ถ้าคำตอบที่สุ่มได้ไม่อยู่ใน excluded_answers ให้ใช้คำตอบนี้
		if not new_answer in excluded_answers:
			nodeSetAnswer.set_answer(new_answer)
			nodeSetAnswer.set_equation( ( num1str + " " + operator[random_operator] + " " + num2str + " = ?" ) )
			nodeSetAnswer.show_equation()
			excluded_answers.append(new_answer)
			return new_answer
	return new_answer
	
func node_show(node: Node2D):
	node.show()
	for child in node.get_Arraychild_nodes() :
		child.show()
	for rainbow in node.get_connect_node() :
		rainbow.show()

func node_hide(node: Node2D):
	node.hide()
	for child in node.get_Arraychild_nodes() :
		child.hide()
	for rainbow in node.get_connect_node :
		rainbow.hide()
	
func set_pos_key(group:Array) :
	var key = key_scene.instantiate()
	key.connect("get_the_key",body_get_key)
	#print("+++++++++++++++++++++++++++++")
	var locationKey = randi_range(0, group.size() - 1 )
	#var locationKey = 0
	#print(group[locationKey].global_position)
	#print("+++++++++++++++++++++++++++++")
	
	
	
	#print(key_node)
	
	key.z_index = 0
	group[locationKey].add_child(key)
	key_node.append(group[locationKey])
	print("gropB : " ,group.size())
	group.pop_at(locationKey)
	print("gropA : " ,group.size())
	
func create_potion( num :int) :

	for i in range(num) :
		
		
		#print("num :", i)
		var random_num = randi_range(1, nodes_random.size() - 1 )
		#var random_num =  node_pack.size() 
		var posion = potion_scene.instantiate()
		var random_node = nodes_random[random_num]
		
		while random_node in key_node :
			random_num = randi_range(1, nodes_random.size() - 1 )
			random_node = nodes_random[random_num]
		
		random_node.add_child(posion)
		potion_node.append(random_node)
		nodes_random.pop_at(random_num)
	
	#print(potion_node)

func body_entered_thedoor(body:Node2D):
	print("เข้าประตู")

var a = 0
func body_get_key(body:Node2D,key:Node2D):
	a += 1
	print("ได้กุญแจ :",a)
	
	key.set_deferred("monitoring", false)
	key.hide()
	
	if a == 3:
		door.show()
		door.set_deferred("monitoring", true)
		#camera.position = door.position
		var tween = create_tween()  # หยุด Tween ก่อนหน้า
		tween.tween_property(camera, "position", door.position, 1.5).set_ease(Tween.EASE_IN_OUT)
		# หน่วงเวลา 1 วินาทีที่ตำแหน่งประตู
		tween.tween_interval(1.0)
		# แพนกล้องกลับมาที่ผู้เล่น
		tween.tween_property(camera, "position", player.position, 1.5).set_ease(Tween.EASE_IN_OUT)

@onready var mana = $cameraOfMain/satamina
var max_mana = 100
var current_health = 100

func used_mana(amount):
	current_health -= amount
	current_health = max(0, current_health) # ห้ามต่ำกว่า 0
	mana.value = current_health
	
