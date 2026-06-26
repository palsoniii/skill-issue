extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_detectstraw_body_entered(body):
	if body.is_in_group("Player"):
		var strawberries = get_tree().get_nodes_in_group("explosive_strawberries")

		for strawberry in strawberries:
			strawberry.start_moving()
