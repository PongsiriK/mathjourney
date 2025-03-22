extends Node2D


var node_scene = preload("res://scenes/newnode.tscn")
#var bridge_scence =  preload("res://scenes/rainbow.tscn")
#var bridge_scence =  preload("res://scenes/newrainbow.tscn")
var bridge_scence =  preload("res://scenes/rainbow_connect.tscn")
var potion_scene = preload("res://scenes/potion.tscn")
var key_scene = preload("res://scenes/key.tscn")
#@onready var player = $Player
@onready var input_answer = $cameraOfMain/LineEdit
@onready var camera = $cameraOfMain
@onready var player = $CharacterBody2D
@onready var door = $door

var pause = false
#var nodes = []
var max_depth = 4
#var numOfNode = 0
var curent_node
var speed = 1200
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


var time_elapsed: float = 0.0  # ตัวแปรเก็บเวลา
var minutes: int = 0  # เก็บจำนวน minutes
var seconds: int = 0  # เก็บจำนวน seconds
var milliseconds: int = 0  # เก็บจำนวน milliseconds

var is_timer_running: bool = false
@onready var time = $cameraOfMain/time

var start = false

func stop_timer() -> void:
	is_timer_running = false  # หยุดการจับเวลา

# ฟังก์ชันสำหรับเริ่มนับต่อ
func start_timer() -> void:
	is_timer_running = true
#func start_timer():
	#is_running = true
#
#func stop_timer():
	#is_running = false
#
#func reset_timer():
	#is_running = false
	#time_elapsed = 0.0
	#time.text = "Time: 0.00"
var minutes_text = "00"
var seconds_text = "00"
var milliseconds_text = "00"
@onready var score_show = $cameraOfMain/score
var score = 0 

func start_game_now():
	camera.pause_set(true)
	input_answer.editable = false
	await wait(3)
	camera.pause_set(false)
	input_answer.editable = true
	
@onready var push_score = $cameraOfMain/score/push
func add_score(num:int):
	score += num
	score_show.text = str(score)
	show_floating_text(str(num) + "+",push_score)

func show_floating_text(text_to_show: String ,label:Label):
	
	label.text = text_to_show
	label.modulate.a = 1 # สีขาว ไม่
	
	var tween = create_tween()
	tween.tween_property(label, "modulate", Color(1, 1, 1, 0), 2).set_trans(Tween.TRANS_LINEAR)
	await tween.finished

#func _process(delta: float) -> void:
func _process(delta: float) -> void:
	
	if is_timer_running:
		time_elapsed += delta
		# คำนวณเวลา
		minutes = int(time_elapsed) / 60  # หามินาที
		seconds = int(time_elapsed) % 60  # หาวินาที
		milliseconds = int(time_elapsed * 100) % 100
		
		minutes_text = "%02d" % int(minutes)
		seconds_text = "%02d" % int(seconds)
		milliseconds_text = "%02d" % int(milliseconds)

# รวมข้อความทั้งหมด
		time.text = minutes_text + ":" + seconds_text + ":" + milliseconds_text # หาค่ามิลลิวินาที
# แสดงผล

################################################################################################################	
	#var direction = Vector2.ZERO
#
#
	#if Input.is_action_pressed("up"):  # กด D
		#direction.y -= 1
		#
		#
	#if Input.is_action_pressed("down"):   # กด A
		#direction.y += 1
		#
	#if Input.is_action_pressed("left"):   # กด S
		#direction.x -= 1
	#if Input.is_action_pressed("rigth"):     # กด W
		#direction.x += 1
#
	#if direction != Vector2.ZERO:
		#direction = direction.normalized()  # ป้องกันการเคลื่อนที่เร็วขึ้นเมื่อกดสองปุ่มพร้อมกัน
#
	#
	#player.position += direction * speed * delta
###############################################################################################################
var r = 350
var time_text = minutes_text + ":" + seconds_text + ":" + milliseconds_text
func _ready() -> void:
	
	pause_scene.connect("resume_game",unpause)
	time.text = minutes_text + ":" + seconds_text + ":" + milliseconds_text
	key_1.modulate.a = 0.5
	key_2.modulate.a = 0.5
	key_3.modulate.a = 0.5
	#show_key.modulate.a = 0.5
	score_show.text = str(score)
	
	#popup_window.hide()
	#close_button.connect("pressed", Callable(self, "_on_close_pressed"))
	mana.value = current_mana
	show_mana.text =  str(current_mana) + " / 100"
	### set start 
	var center_position = get_viewport_rect().size / 2  # จุดศูนย์กลางของหน้าจอ
	var radius = r  # ระยะห่างจากจุดศูนย์กลาง
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
	start_game_now()
	game_over.mode = 3
# ฟังก์ชันสร้างโหนดลูก
func create_child_nodes(parent_node: Node2D, parent_angle: float, depth: int , group: int) -> void:
	#if depth == max_depth - 1 :
		#print
	if depth >= max_depth:
		match group:
			1:
				node_random_key1.append(parent_node)
			2:
				node_random_key2.append(parent_node)
			3:
				node_random_key3.append(parent_node)
		return  # หยุดเมื่อถึงระดับที่กำหนด
	
	
		
	
	
	var radius_node = r - (depth*10)  # ลดระยะห่างเมื่อระดับสูงขึ้น
	
	match group:
			1:
				if depth == max_depth - 1 :
					radius_node -= 50
			2:
				if depth == max_depth - 1 :
					radius_node -= 40
			3:
				if depth == max_depth - 1 :
					radius_node -= 30
	
	#var radius_node = r + (depth*10)
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

var start_first = false

func _on_area_2d_body_entered(node :Node2D,body: Node2D) -> void:	
	if body == player:
		
		#var Answers = []
		curent_node = node
		
		#print("position of node: ",curent_node.global_position)
		#print("position of player: ",player.position)
		node_show(node)
		node.hide_equation()
		
		if start_first :
		
			if node.on_first() :
				add_score(500)
			else :
				add_score(100)
		
		start_first = true
		
		#print("Player เข้ามาในโหนด:", node.name )
		#var pack_answer = []
		#if node.get_parent_node() != null :
			#Answers.append(node.get_parent_node().get_answer())
			###print(pack_answer)
			###pack_answer.append(random_equation(node.get_parent_node(),pack_answer))
			##print("mom: ",node.get_parent_node().name)
		#if node.get_Arraychild_nodes() != null :
			##var i = 1
			#for child in node.get_Arraychild_nodes() :
				#Answers.append(child.get_answer())
				
				
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
		#checkAnswer = []
		var pack_answer = []
		if node.get_parent_node() != null :
			pack_answer.append(node.get_parent_node().get_answer())
			if node.get_parent_node().get_parent_node() != null :
				pack_answer.append(node.get_parent_node().get_parent_node().get_answer())
			if node.get_parent_node().get_Arraychild_nodes() != null :
				for child in node.get_parent_node().get_Arraychild_nodes() :
					pack_answer.append(child.get_answer())
		if node.get_Arraychild_nodes() != null :
			for child in node.get_Arraychild_nodes() :
				pack_answer.append(child.get_answer())
				if child.get_Arraychild_nodes() != null :
					for grand_child in child.get_Arraychild_nodes() :
						pack_answer.append(grand_child.get_answer())
		random_equation(node,pack_answer)
		node.not_first()
		#for i in pack_answer :
			#print(i)
		#if node.get_answer() in pack_answer:
			#pack_answer.erase(node.get_answer())
			#checkAnswer = checkAnswer.filter(func(x): return x != node.get_answer())
			
		
		
	
	
	
#func move_player_to_node(target_node: Node2D) -> void:
	#
	#var tween = create_tween()  # หยุด Tween ก่อนหน้า
	##tween.tween_property(camera, "position", player.position, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	##tween.tween_property(player, "global_position",target_node.global_position, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#player.global_position = target_node.global_position
	#var tween1 = create_tween()
	#
	#tween1.tween_property(camera, "position", player.position, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	##camera.position = player.
	##player.position = target_node.to_local(player.global_position)
	#print(curent_node.global_position)
	#print(target_node.global_position)
	
func move_player_to_node(target_node: Node2D) -> void:
	# สร้าง Tween เพื่อย้ายผู้เล่นไปยังตำแหน่งของ target_node
	var tween = create_tween() 
	#camera.global_position = target_node.global_position  # ย้ายผู้เล่นไปยังตำแหน่งของโหนด
	tween.tween_property(camera, "global_position", target_node.global_position, 0.5 ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# สร้าง Tween สำหรับกล้องเพื่อให้กล้องตามผู้เล่น
	var tween1 = create_tween()
	tween1.tween_property(player, "global_position", target_node.global_position, 0.75 ).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	if target_node.global_position.x < player.global_position.x :
		player.play_jump_L() 
	if target_node.global_position.x >= player.global_position.x :
		player.play_jump_R() 
	#check_current_node()

@onready var in_show = $cameraOfMain/LineEdit/in
func _on_line_edit_text_submitted(new_text: String) -> void:
	input_answer.text = ""
	if not start :
		start_timer()
		start = true
	used_mana()
	#print("ans ",new_text)
	var corect = false
	var pack_answer = []
	if curent_node.get_parent_node()!= null :
		pack_answer.append(curent_node.get_parent_node().get_answer())
		if new_text.strip_edges() == str(curent_node.get_parent_node().get_answer()):
			move_player_to_node(curent_node.get_parent_node())
			corect = true
			
			
	if curent_node.get_Arraychild_nodes() != null :
		for child in curent_node.get_Arraychild_nodes() :
				pack_answer.append(child.get_answer())
				if new_text.strip_edges() == str(child.get_answer()) :
					move_player_to_node(child)
					corect = true
	
	
	if not corect :
		player.wrong()
		in_show.modulate = Color.RED
		used_mana()
	else :
		in_show.modulate = Color.GREEN
	show_floating_text(new_text,in_show)
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
		num1 = randi_range(0, 99)
		num2 = randi_range(0, 99)
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
					num2 = randi_range(0, 9)
					if num2 < 0 :
						num2str = "(" + str(num2) +  ")"
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

	group.pop_at(locationKey)
	
	
func create_potion( num :int) :

	for i in range(num) :
		
		
		#print("num :", i)
		var random_num = randi_range(1, nodes_random.size() - 1 )
		#var random_num =  node_pack.size() 
		var potion = potion_scene.instantiate()
		potion.connect("get_potion",body_get_potion)
		var random_node = nodes_random[random_num]
		
		while random_node in key_node :
			random_num = randi_range(1, nodes_random.size() - 1 )
			random_node = nodes_random[random_num]
		
		random_node.add_child(potion)
		potion_node.append(random_node)
		nodes_random.pop_at(random_num)
	
	#print(potion_node)

func body_entered_thedoor(body:Node2D):
	time_elapsed
	var result_text = "Congratulations! You have completed this level!"
	
	var min_time = 30
	var max_time = 600
	var max_score = 5000
	stop_timer()
# คำนวณคะแนน
	score += calculate_score(time_elapsed, max_time, min_time, max_score)
	
	show_game_over_popup()
	

	
#@onready var show_key = $"cameraOfMain/24579420f6Eb1d2/key"


func calculate_score(time_elapsed: float, max_time: float, min_time: float, max_score: int) -> int:
	# คำนวณเวลาที่ใช้ในช่วงเวลาที่สามารถได้คะแนน
	var normalized_time = clamp(time_elapsed, min_time, max_time) # จำกัดให้เวลาอยู่ในช่วงที่ตั้งไว้
	var score = max_score - int((normalized_time - min_time) / (max_time - min_time) * max_score)

	return score

var key_num = 0
func body_get_key(body:Node2D,key:Node2D):
	
	if body == player :
		key_num += 1
		#show_key.text = "x " + str(key_num)
		key.set_deferred("monitoring", false)
		key.hide()
		#show_key.modulate.a = 1.0
		add_score(500)
		show_num_key()
		player.yeah()
		if key_num == 3:
			camera.pause_set(true)
			#camera.position = door.position
			var tween = create_tween()  # หยุด Tween ก่อนหน้า
			tween.tween_property(camera, "position", door.position, 1).set_ease(Tween.EASE_IN_OUT)
			tween.tween_interval(2.0)
			tween.tween_property(camera, "position", player.position, 1).set_ease(Tween.EASE_IN_OUT)
			# หน่วงเวลา 1 วินาทีที่ตำแหน่งประตู
			
			
			await wait(1)
			door.show()
			door.open()
			door.set_deferred("monitoring", true)
			
			await wait(2.5)
			camera.pause_set(false)
			
			
			
			# แพนกล้องกลับมาที่ผู้เล่น
			

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
	
@onready var key_1 = $cameraOfMain/key1
@onready var key_2 = $cameraOfMain/key2
@onready var key_3 = $cameraOfMain/key3


func show_num_key():
	if key_num == 1 :
		key_1.modulate.a = 1.0
	if key_num == 2:
		key_2.modulate.a = 1.0
	if key_num == 3:
		key_3.modulate.a = 1.0
	

func body_get_potion(body:Node2D,potion:Node2D):
	if body == player:
		plus_mana(10)
		potion.set_deferred("monitoring", false)
		potion.hide()
		
		
		

@onready var mana = $cameraOfMain/satamina
@onready var show_mana = $cameraOfMain/satamina/mana
var max_mana = 100
var current_mana = 100


func plus_mana(num:int):
	current_mana += num
	#current_mana = max(0, max_mana) 
	current_mana = min(max_mana, current_mana)
	mana.value = current_mana
	show_mana.text =  str(current_mana) + " / 100"
	
func used_mana():
	current_mana -= 1
	#current_mana = max(0, current_mana) 
	current_mana = max(0, current_mana)
	mana.value = current_mana
	show_mana.text =  str(current_mana) + " / 100"
	#mana.visible = true
	if current_mana == 0 :
		show_game_over_lose()



#@onready var popup_window = $Window
#@onready var result_label = $Window/Label
#@onready var close_button = $Window/Button
	

#func show_result(result_text: String):
	#result_label.text = result_text
	#popup_window.popup_centered()

#@onready var popup = $Endgame

#func show_game_over_popup():
	#popup.popup_centered(Vector2(720, 720)) 
	#popup.position = (get_viewport_rect().size - popup.size) / 2
	#popup.show()
#@onready var dialog = $AcceptDialog

@onready var game_over = $gameover
@onready var lose = $game_over

func show_game_over_lose():
	flash_white_screen(2.0, 2.0)
	lose.play()
	game_over.allow_all()
	camera.global_position = game_over.global_position
	game_over.result_score(score, minutes,seconds,milliseconds,"YOU LOSE")
	camera.pause_set(true)
	for element in camera.get_children():
		element.visible = false
	pause_but.disabled = true
	input_answer.editable = true


func show_game_over_popup():
	flash_white_screen(2.0, 2.0)
	win.play()
	game_over.allow_all()
	camera.global_position = game_over.global_position
	game_over.result_score(score, minutes,seconds,milliseconds,"YOU WIN")
	camera.pause_set(true)
	for element in camera.get_children():
		element.visible = false
	pause_but.disabled = true
	input_answer.editable = true
		
@onready var pause_but = $cameraOfMain/p
@onready var pause_scene = $pause_scene
func pause_game () :
	pause_scene.allow_all()
	pause = true
	pause_scene.global_position.x = get_viewport_rect().size.x / 2
	pause_scene.global_position.y = get_viewport_rect().size.y - 2000
	var tween = create_tween()  # หยุด Tween ก่อนหน้า
	tween.tween_property(pause_scene, "global_position", camera.global_position, 1).set_ease(Tween.EASE_IN_OUT)
	pause_scene.global_position 
	
	stop_timer()
	camera.pause_set(true)
	input_answer.hide()
	input_answer.editable = false
	pause_but.hide()
	
#func show_game_over_popup():
	#
	#window.size = Vector2(400, 300)
	#
	#window.title = "Game Over"
	#window.show()
#
#func _on_retry_button_pressed():
	#print("เล่นต่อ")
	#window.hide()
#
#func _on_home_button_pressed():
	#print("กลับหน้าแรก")
	#window.hide()

func unpause():
	pause_scene.dis_all()
	pause = false
	start_timer()
	camera.pause_set(false)
	input_answer.show()
	input_answer.editable = true
	pause_but.show()
	


func flash_white_screen(duration: float = 1.0, wait_time: float = 1.0):
	var white_screen = ColorRect.new()
	white_screen.color = Color(1, 1, 1, 1) # สีขาวทึบ
	white_screen.size = Vector2(5000,5000)
	white_screen.z_index = 25
	add_child(white_screen)

	await get_tree().create_timer(wait_time).timeout # รอ wait_time วินาที
	
	var tween = create_tween()
	tween.tween_property(white_screen, "modulate", Color(1, 1, 1, 0), duration).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	white_screen.queue_free()

@onready var win = $win
func _on_p_pressed() -> void:
	pause_game()
