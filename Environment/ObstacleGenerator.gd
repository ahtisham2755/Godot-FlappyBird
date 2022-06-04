extends Node2D

signal obstical_created(obs)

onready var timer = $Timer

var Obstacle = preload("res://Environment/Obstacle.tscn")

func _ready():
	randomize()

func _on_Timer_timeout():
	genrate_Obstacle()

func genrate_Obstacle():
	var obstacle = Obstacle.instance()
	# give random between 150 and 550
	obstacle.position.x = 800
	obstacle.position.y = randi()%310 + 150
	add_child(obstacle)
	emit_signal("obstical_created",obstacle)

func start():
	timer.start()

func stop():
	timer.stop()
