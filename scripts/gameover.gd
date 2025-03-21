extends Node2D

@onready var score_show = $score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().size / 2
	hide()

func result_score(score:int):
	score_show.text = str(score)



# Called every frame. 'delta' is the elapsed time since the previous fram
