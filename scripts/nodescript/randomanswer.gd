extends Node

var operator:Array = ["+","-","*","/"]
var result
#func _ready() -> void:
	#print("from random")
	#generate_equation()
	#print(result)
func generate_equation()-> String :
	
	var num1 = randi_range(-9, 9)
	#var num2 = 0
	var num2 = randi_range(-9, 9)
	var random_operator = randi_range(0, 3)
	
	
	match random_operator :
		0:
			result = num1 + num2
		1:
			result = num1 - num2
		2:
			result = num1 * num2
		3:	
			while num2 == 0 or num1 % num2 != 0:  
				num2 = randi_range(-9, 9)  # สุ่ม num2 ใหม่จนกว่าจะหารลงตัวและไม่เป็น 0
			result = num1 / num2
				
	
	return  str(num1, " ", operator[random_operator]," ", num2, " = ?")
		
#func return_answer()-> int :
	 #result
	
