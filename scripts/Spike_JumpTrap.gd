extends Node2D

@export var move_distance := 40
@export var move_speed := 200
@export var move_direction := Vector2(1,0) # change per spike

var moving := false
var triggered := false
var target_position : Vector2

func _process(delta):
	if moving:
		global_position = global_position.move_toward(target_position, move_speed * delta)

		if global_position.distance_to(target_position) < 1:
			moving = false


func trigger_spike():
	if triggered:
		return   # prevents multiple triggers
		
	triggered = true

	target_position = global_position + move_direction * move_distance
	moving = true
