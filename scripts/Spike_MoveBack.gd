extends Node2D

@export var move_distance := 40
@export var move_speed := 200

var moving = false
var target_position

func _physics_process(delta):
	if moving:
		global_position = global_position.move_toward(target_position, move_speed * delta)

		if global_position.distance_to(target_position) < 1:
			moving = false

func trigger_spike():
	if moving:
		return
		
	target_position = global_position + Vector2(-move_distance, 0)
	moving = true
