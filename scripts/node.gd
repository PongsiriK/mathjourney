#extends Node2D
#
#var operator:Array = ["+", "-", "*", "/"]
#var result
#var equation_label : Label
 ## เก็บโหนดลูก
#var parent_node : Node2D  # เก็บโหนดแม่ (ถ้ามี)
#var namennn = fine_relation_node(self.name)
#
#func _ready():
	#var child_nodes = [get_node($"../Node"+str(fine_relation_node(self.name)*3))]
	#print(fine_relation_node(self.name),"+",namennn)
	#
	##var child = "Node2"
	#hide()
	#equation_label = $Label  # สมการจะแสดงที่นี่
	#generate_equation()  # สร้างสมการตอนเริ่มต้น
	##add_child_node()
#
## ฟังก์ชันที่สร้างสมการใหม่
#func generate_equation() -> void:
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
	#equation_label.text = str(num1, " ", operator[random_operator], " ", num2, " = ?")
#
### เมื่อผู้เล่นยืนอยู่บนโหนดนี้
##func on_player_enter() -> void:
	##equation_label.visible = false  # ซ่อนสมการเมื่อยืนอยู่บนโหนด
##
### เมื่อผู้เล่นออกจากโหนดนี้
##func on_player_exit() -> void:
	##generate_equation()
	##equation_label.visible = true  # แสดงสมการใหม่เมื่อออกจากโหนด
	  ## สร้างสมการใหม่
#
## เพิ่มโหนดลูกใหม่ให้กับโหนดนี้
#func add_child_node(child_node : Node2D) -> void:
	#child_nodes.append(child_node)
	#child_node.parent_node = self  # ตั้งค่าแม่ให้กับลูก
##
### เมื่อผู้เล่นเคลื่อนที่ไปยังโหนดลูก ให้แสดงโหนดลูกและซ่อนสมการ
##func move_to_child_node(child_node : Node2D) -> void:
	##self.position = child_node.position
	##child_node.on_player_enter()  # เรียกฟังก์ชันเมื่อยืนบนโหนดนั้น
	##if parent_node != null:
		##parent_node.on_player_exit()  # เมื่อออกจากโหนดแม่
#
#
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#
	#
	#show()
	#
	#equation_label.visible = false
	#
#
#
#func _on_area_2d_body_exited(body: Node2D) -> void:
	#generate_equation()
	#equation_label.visible = true 
#
#func fine_relation_node(name : String)-> int:
	## ใช้ regular expression ในการค้นหาตัวเลขจากสตริง
	 ## แปลงตัวเลขจากสตริงเป็นตัวเลขจริง
	#return int(name.substr(4, name.length() - 4))  # ถ้าไม่พบตัวเลข คืนค่า -1
extends Node2D

var equation_label : Label
var answer_box : LineEdit
var child_nodes = []  # เก็บโหนดลูก
var parent_node : Node2D  # เก็บโหนดแม่

#func _ready():
	#equation_label = $Label
	#answer_box = $AnswerBox
#
	## เมื่อผู้เล่นกรอกคำตอบและกด Enter
	#answer_box.connect("text_submitted", self, "_on_answer_submitted")

# ฟังก์ชันตรวจสอบคำตอบ
func _on_answer_submitted():
	var correct_answer = evaluate_equation()  # คำนวณคำตอบที่ถูกต้อง
	var user_answer = int(answer_box.text)  # คำตอบที่ผู้เล่นกรอก

	if user_answer == correct_answer:
		print("Correct!")
		move_to_next_node()  # ถ้าคำตอบถูกต้องจะเคลื่อนที่ไปยังโหนดถัดไป
	else:
		print("Wrong answer!")

# ฟังก์ชันคำนวณคำตอบ
func evaluate_equation() -> int:
	var num1 = int(equation_label.text.split(" ")[0])  # ดึงตัวเลขแรก
	var operator = equation_label.text.split(" ")[1]  # ดึง operator
	var num2 = int(equation_label.text.split(" ")[2])  # ดึงตัวเลขที่สอง
	var result = 0

	match operator:
		"+":
			result = num1 + num2
		"-":
			result = num1 - num2
		"*":
			result = num1 * num2
		"/":
			result = num1 / num2
	
	return result

# ฟังก์ชันเคลื่อนที่ไปยังโหนดลูก
func move_to_next_node():
	if child_nodes.size() > 0:
		var next_node = child_nodes[0]  # เลือกโหนดลูกแรก
		get_parent().current_node = next_node  # ย้ายไปยังโหนดลูก
		get_parent().update_node_display(next_node)  # อัปเดตการแสดงผลในโหนดลูก
