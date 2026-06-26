extends Node2D

@export var move_speed := 200
@export var move_direction := Vector2.LEFT

var moving = false

func _ready():
	visible = false

func _physics_process(delta):
	if moving:
		global_position += move_direction * move_speed * delta

func trigger_spike():
	if moving:
		return
		
	visible = true
	moving = true
