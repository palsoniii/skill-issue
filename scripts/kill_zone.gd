extends Area2D

@onready var timer = $Timer
@onready var death_sound = $DeathSound
@onready var death_text = get_tree().current_scene.get_node("UI/DeathText")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		death_text.visible = true
		timer.start()
		death_sound.play()
	

func _on_timer_timeout():
	get_tree().reload_current_scene()
