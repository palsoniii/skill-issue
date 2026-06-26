extends Node2D

@export var move_distance := 50   # Only used to determine initial direction
@export var move_speed := 200

var moving = false
var move_direction := Vector2.ZERO

func _physics_process(delta):
	if moving:
		global_position += move_direction * move_speed * delta

func trigger_spike():
	if moving:
		return
	
	# Set direction once when triggered
	move_direction = Vector2(-1, 0)   # Left movement
	moving = true
