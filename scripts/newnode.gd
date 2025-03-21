extends Node2D

# รายการของโหนดลูก
var child_nodes = []
var myParent_node 
#var my = preload("res://scenes/newnode.tscn")
@onready var display_equation = $Label
var answer : int 
var connect_to = []
#var player = preload("res://scenes/player.tscn").instantiate()

func _ready() -> void:
	hide()
	

func add_connect_node(rainbow:Node2D):
	connect_to.append(rainbow)

func get_connect_node() -> Array:
	return connect_to

func set_equation(equation:String):
	display_equation.text = equation

	#show_equation.text = generate_equation()
	
func add_myParent(node:Node2D):
	myParent_node = node
# ฟังก์ชั่นเพิ่มโหนดลูก
func add_child_node(node:Node2D):
	child_nodes.append(node)
	#
#func _ready() -> void:
	#var node_son = my.instantiate()
	##node_son.name = get_name 
	#add_child(node_son)
var operator:Array = ["+","-","*","/"]


#func generate_equation()-> String :
	#
	#var num1 = randi_range(-9, 9)
	##var num2 = 0
	#var num2 = randi_range(-9, 9)
	#var random_operator = randi_range(0, 3)
	#
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
				#@warning_ignore("integer_division")
				#answer = num1 / num2
				#
	#
	#return  str(num1, " ", operator[random_operator]," ", num2, " = ?")

func set_answer(ans: int):
	answer = ans

func get_answer() -> int:
	#print("answer:", answer)
	return answer

func get_child_nodes(num:int) -> Node2D :
	return child_nodes[num]

func get_Arraychild_nodes() -> Array :
	return child_nodes
	
func get_parent_node() -> Node2D :
	return myParent_node
	
func show_equation() :
	
	var colors = [
		Color(1, 0, 0),    # แดง
		Color(1, 0.5, 0),  # ส้ม
		Color(1, 1, 0),    # เหลือง
		Color(0, 1, 0),    # เขียว
		Color(0, 0, 1),    # น้ำเงิน
		Color(0.29, 0, 0.51), # คราม
		Color(0.56, 0, 1)  # ม่วง
	]
	var random_color = colors[randi_range(0,colors.size()-1)]
	display_equation.modulate = random_color 
	display_equation.show()

func hide_equation() :
	display_equation.hide()
	






signal player_entered_area(Mynode:Node2D,body: Node2D)
# ฟังก์ชั่นที่ตรวจจับการเข้าไปของ player
func _on_area_2d_body_entered(body: Node2D) -> void :
	#show()
	emit_signal("player_entered_area", self , body)
		
	#print("++++++++++++++++++" , name,"  ",body)


signal player_exited_area(Mynode:Node2D,body: Node2D)

	
func _on_area_2d_body_exited(body: Node2D) -> void:
	
	emit_signal("player_exited_area", self , body)

var first = true
func not_first() :
	first = false

func on_first() -> bool:
	return first
