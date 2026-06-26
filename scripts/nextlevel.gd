extends Area2D

const file_begin = "res://scenes/level_"
func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("You just Skilled Up")
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 2
		print(next_level_number)
		
		var next_level_path = file_begin + str(next_level_number) + ".tscn"
		call_deferred("_go_to_next_level", next_level_path)

func _go_to_next_level(path):
	get_tree().change_scene_to_file(path)

	

	
	

