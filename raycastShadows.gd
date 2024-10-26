extends RayCast2D
var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enabled = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!enabled):
		return
	set_target_position(player.global_position-global_position)
	print(get_collider())
	if(get_collider() is CharacterBody2D):
		get_tree().quit()
	pass
