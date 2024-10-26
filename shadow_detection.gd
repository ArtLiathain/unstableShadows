extends PointLight2D

var raycastNode 

func _ready():
	# Get a reference to the player node
	raycastNode = $RayCast2D
	pass

func _process(delta):
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		raycastNode.enabled = true
		raycastNode.player = body
		print("Hello")
		
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		raycastNode.enabled = false
		print("Hello")
	pass # Replace with function body.
