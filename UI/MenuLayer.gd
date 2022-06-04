extends CanvasLayer

onready var start_message = $StartMenu/StartMessage
onready var tween = $Tween
onready var score_lable = $GameOverMenu/VBoxContainer/ScoreLable
onready var high_score_lable = $GameOverMenu/VBoxContainer/HighScoreLable
onready var game_over_menu = $GameOverMenu

signal started

var GameStarted = false

func _input(event):
	if event.is_action_pressed("flap") && !GameStarted:
		emit_signal("started")
		tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.5)
		tween.start()
		GameStarted = true

func init_game_over_menu(score, highscore):
	score_lable.text = "SCORE: " + str(score)
	high_score_lable.text = "BEST: " + str(highscore)
	game_over_menu.visible = true 

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
