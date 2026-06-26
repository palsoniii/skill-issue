extends CharacterBody2D

@export var gravity := 1500.0
@export var fall_delay := 0

var falling := false

func _physics_process(delta):
	if falling:
		velocity.y += gravity * delta
		move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		await get_tree().create_timer(fall_delay).timeout
		falling = true



