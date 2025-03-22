extends Node2D

@onready var resume = $re
@onready var back = $ba
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 11
	dis_all()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dis_all():
	hide()
	resume.disabled = true
	back.disabled = true

func allow_all():
	show()
	resume.disabled = false
	back.disabled = false


signal resume_game


func _on_re_pressed() -> void:
	emit_signal("resume_game")


func _on_ba_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
