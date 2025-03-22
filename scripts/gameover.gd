extends Node2D

@onready var score_show = $sco
@onready var again = $again_B
@onready var back = $back_B
@onready var time_show = $time
@onready var result_s = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 11
	position = get_viewport_rect().size / 2
	dis_all()



func result_score(score:int,m,n,s,result):
	result_s.text = result
	score_show.text = str(score)
	time_show.text = str(m) + ":" + str(n) + ":" + str(s)
	

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func animate_number(label: Label, target_number: int, duration: float = 2.0):
	var tween = create_tween()
	var current_number = 0
	
	tween.tween_method(func(value): 
		label.text = str(int(value)), 
		current_number, target_number, duration
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)

func animate_time(label: Label, target_minutes: int, target_seconds: int,m, duration: float = 2.0):
	var target_time = (target_minutes * 60) + target_seconds
	var current_time = 0
	var tween = create_tween()

	# Tween ค่อยๆ เปลี่ยนค่า
	tween.tween_method(func(value):
		# แยกค่าเป็นนาทีและวินาที
		var minutes = int(value) / 60
		var seconds = int(value) % 60
		var mini = int(value)  
		# สร้างข้อความแสดงเวลา
		var minutes_text = "%02d" % minutes
		var seconds_text = "%02d" % seconds
		var milliseconds_text = "00" # หรือใส่ค่ามิลลิวินาทีถ้าต้องการ

		# รวมข้อความทั้งหมด
		label.text = minutes_text + ":" + seconds_text + ":" + milliseconds_text

	, current_time, target_time, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)

func dis_all():
	hide()
	again.disabled = true
	back.disabled = true

func allow_all():
	show()
	again.disabled = false
	back.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous fram
	
var mode 

func _on_again_b_pressed() -> void:
	match mode :
		1:
			get_tree().change_scene_to_file("res://scenes/playgame_easy.tscn")
		2:
			get_tree().change_scene_to_file("res://scenes/playgame_easy_mid.tscn")
		3:
			get_tree().change_scene_to_file("res://scenes/playgame_easy_hard.tscn")

func _on_back_b_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
