extends Area2D

func _on_body_entered(body):
	print("Something entered:", body.name)
	
	if body.is_in_group("Player"):
		print("Player detected!")
		body.die()
