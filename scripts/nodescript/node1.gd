extends Node2D


var result
var equation_label : Label
var index_node = 1
@onready var perent_node : Node2D = null
@onready var child_node = [$"../Node2",$"../Node3",$"../Node4"]

var awswer_move =[]

func _ready() -> void:
	
	hide()
	equation_label = $Label
	generate_equation()
	print($"../Node2".result)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_equation() -> void:
	var operator:Array = ["+", "-", "*", "/"]
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
	
	print("เฉลย ", result)
	equation_label.text = str(num1, " ", operator[random_operator], " ", num2, " = ?")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	get_parent().current_node = index_node
	
	
	get_parent().current_answers = [0, child_node[0].result ,child_node[1].result,child_node[2].result]
	
	
	show()
	equation_label.visible = false
	for i in child_node :
		i.show()
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	generate_equation()
	equation_label.visible = true 
