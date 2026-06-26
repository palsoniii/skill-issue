extends Area2D

enum StrawberryType {
	COLLECTIBLE,
	PLATFORM,
	EXPLOSIVE
}

@export var strawberry_type : StrawberryType = StrawberryType.COLLECTIBLE
@export var move_speed := 150.0
@export var move_direction := Vector2.RIGHT

@onready var sprite = $AnimatedSprite2D
@onready var stand_body = $StaticBody2D
@onready var collect_shape = $CollectShape

@onready var pop_sound = $PopSound
@onready var explode_sound = $ExplodeSound

var collected := false
var moving := false


func _ready():
	sprite.play("idle")

	match strawberry_type:
		StrawberryType.COLLECTIBLE:
			stand_body.process_mode = Node.PROCESS_MODE_DISABLED

		StrawberryType.PLATFORM:
			monitoring = false
			collect_shape.disabled = true

		StrawberryType.EXPLOSIVE:
			stand_body.process_mode = Node.PROCESS_MODE_DISABLED
			add_to_group("explosive_strawberries")


func _physics_process(delta):
	if moving:
		position += move_direction * move_speed * delta


func start_moving():
	moving = true


func _on_body_entered(body):
	if !body.is_in_group("Player"):
		return

	match strawberry_type:

		StrawberryType.COLLECTIBLE:
			if !collected:
				collected = true
				collect()

		StrawberryType.EXPLOSIVE:
			explode(body)


func explode(player):
	monitoring = false
	collect_shape.disabled = true

	# play explosion sound
	explode_sound.play()

	sprite.play("collect")
	await sprite.animation_finished

	player.die()


func collect():
	monitoring = false

	# play pop sound
	pop_sound.play()

	sprite.play("collect")
	position.y -= 5

	await sprite.animation_finished
	queue_free()
