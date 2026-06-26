extends CharacterBody2D

var SPEED = 130.0
var JUMP_VELOCITY = -350.0

# Control system
var control_multiplier := 1   # 1 = normal, -1 = inverted

# Gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Death state
var dead := false

# Screen wrap toggle
var screen_wrap_enabled := false

# Level boundaries
var LEFT_BOUNDARY := 0
var RIGHT_BOUNDARY := 1150

@onready var animated_sprite = $AnimatedSprite2D
@onready var death_sound = $DeathSound


func _ready():
	# Detect if this is the special wrap level
	var scene_path = get_tree().current_scene.scene_file_path
	var level_name = scene_path.get_file().get_basename()

	if level_name == "level_24":
		screen_wrap_enabled = true


func die():
	if dead:
		return
		
	dead = true

	var death_text = get_tree().current_scene.get_node("UI/DeathText")
	var flash = get_tree().current_scene.get_node("UI/DamageFlash")
	var camera = get_viewport().get_camera_2d()
	death_sound.play()


	death_text.visible = true

	set_physics_process(false)
	velocity = Vector2.ZERO

	# Flash immediately
	flash.color = Color(1,0,0,0.35)

	camera_shake(camera)

	await get_tree().create_timer(0.12).timeout
	flash.color.a = 0

	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()


func camera_shake(camera):

	if camera == null:
		return

	var original_position = camera.position

	for i in range(20):
		camera.position = original_position + Vector2(
			randf_range(-15,15),
			randf_range(-15,15)
		)
		await get_tree().create_timer(0.015).timeout

	camera.position = original_position


# Invert controls trigger
func invert_controls():
	control_multiplier *= -1
	print("Controls inverted")


func _physics_process(delta):

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement input (with inversion)
	var direction = Input.get_axis("left", "right") * control_multiplier

	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Horizontal movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


	# Screen wrap (ONLY for level_24)
	if screen_wrap_enabled:
		
		SPEED = 250
		JUMP_VELOCITY = -430

		if position.x > RIGHT_BOUNDARY:
			position.x = LEFT_BOUNDARY + 5

		elif position.x < LEFT_BOUNDARY:
			position.x = RIGHT_BOUNDARY - 5
			
