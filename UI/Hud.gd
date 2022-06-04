extends CanvasLayer

onready var score_lable = $Score

var alive = true

func update_Score(score):
	if alive:
		score_lable.text = str(score)
	
