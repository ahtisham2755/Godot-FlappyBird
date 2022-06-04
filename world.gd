extends Node2D

onready var hud = $Hud
onready var obsticalGenrator = $ObstacleGenerator
onready var ground = $Ground
onready var menu_layer = $MenuLayer

const SaveFilePath = "user://savedata.save"
var score = 0 setget set_score
var highscore = 0

func _ready():
	obsticalGenrator.connect("obstical_created", self, "_on_obstical_created")
	obsticalGenrator.stop()
	get_tree().call_group("obtacles", "set_physics_process", false)
	print("stoped")
	LoadHighScore()

func new_game():
	self.score = 0
	obsticalGenrator.start()

func player_score():
	self.score += 1

func set_score(new_score):
	score = new_score
	hud.update_Score(score)

func _on_obstical_created(obs):
	obs.connect("score", self , "player_score")

func _on_DeathZone_body_entered(body):
	if body is player:
		if body.has_method("die"):
			body.die()

func _on_player_died():
	game_over()

func game_over():
	hud.alive = false
	obsticalGenrator.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obtacles", "set_physics_process", false)
	if score > highscore:
		highscore = score
		SaveHighScore(highscore)
	menu_layer.init_game_over_menu(score, highscore)

func SaveHighScore(high_score):
	var save_data = File.new()
	save_data.open(SaveFilePath, File.WRITE)
	save_data.store_var(high_score)
	save_data.close()

func LoadHighScore():
	var save_data = File.new()
	if save_data.file_exists(SaveFilePath):
		save_data.open(SaveFilePath, File.READ)
		highscore = save_data.get_var()
		save_data.close()

func _on_MenuLayer_started():
	new_game()


func _on_UpperDeathZone_body_entered(body):
	if body is player:
		if body.has_method("die"):
			body.die()


func _on_player_GameStarted():
	get_tree().call_group("obtacles", "set_physics_process", true)
	obsticalGenrator.start()
