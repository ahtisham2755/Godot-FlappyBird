extends Node2D

onready var score = $Score
   
signal score
var alive = true


const SPEED = 200

func _physics_process(delta):
	position.x += (-SPEED) * delta
	if global_position.x <= -200:
		queue_free()

func _on_wall_body_entered(body):
	if body is player:
		if body.has_method("die"):
			alive = false
			body.die()

func _on_scoreArea_body_exited(body):
	if body is player:
		emit_signal("score")
		if alive:
			score.play()
		
