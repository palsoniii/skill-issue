extends Area2D

@onready var control_sound = $ControlSound

var triggered := false

func _on_body_entered(body):

	if triggered:
		return

	if body.is_in_group("Player"):
		triggered = true
		
		# play sound
		control_sound.play()
		
		# flip controls
		body.invert_controls()

		# camera shake
		var camera = get_viewport().get_camera_2d()
		camera_shake(camera)

		# disable trigger permanently
		monitoring = false
		
		
func camera_shake(camera):

	if camera == null:
		return

	var original_position = camera.position

	for i in range(12):
		camera.position = original_position + Vector2(
			randf_range(-40,40),
			randf_range(-40,40)
		)

		await get_tree().create_timer(0.02).timeout

	camera.position = original_position
