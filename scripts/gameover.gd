extends Node2D

@onready var score_show = $score
@onready var again = $again
@onready var back = $back
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 11
	position = get_viewport_rect().size / 2
	dis_all()

func result_score(score:int):
	score_show.text = str(score)

func dis_all():
	hide()
	again.disabled = true
	back.disabled = true

func allow_all():
	show()
	again.disabled = false
	back.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous fram


func _on_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/newmain.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
