extends CanvasLayer

@onready var dot1 = $HBoxContainer/Dot1
@onready var dot2 = $HBoxContainer/Dot2
@onready var dot3 = $HBoxContainer/Dot3

var dots = []

func _ready():
	dots = [dot1, dot2, dot3]
	update_from_scene()

func update_from_scene():
	var scene_path = get_tree().current_scene.scene_file_path
	
	# Extract level number from file name
	var level_number = scene_path.get_file().get_basename().trim_prefix("level_").to_int()
	
	# Convert level number to segment index (since levels increase by +2)
	var segment_index = int(level_number / 2)
	
	# Determine which section of the level we are in (repeat every 3)
	var section_number = (segment_index % dots.size()) + 1
	
	update_section(section_number)

func update_section(section_number: int):
	for i in range(dots.size()):
		if i < section_number:
			dots[i].modulate.a = 1.0
		else:
			dots[i].modulate.a = 0.25
			
@onready var death_text = $DeathText




func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")



