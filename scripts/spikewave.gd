extends Node2D

@export var delay_between_spikes := 0.1

var activated := false

@onready var activation_area := $ActivationArea


func _ready():
	for child in get_children():
		if child is Sprite2D:
			child.hide()

		if child is Area2D and child != activation_area:
			child.monitoring = false


func _on_activation_area_body_entered(body):
	if activated:
		return

	if body.is_in_group("Player"):
		activated = true
		activate_wave()


func activate_wave():

	# Get all children in order
	var children = get_children()

	for i in range(children.size()):
		var child = children[i]

		# Activate sprite
		if child is Sprite2D:
			child.show()

			# The next child should be its trigger area
			if i + 1 < children.size() and children[i + 1] is Area2D:
				children[i + 1].monitoring = true

			await get_tree().create_timer(delay_between_spikes).timeout
