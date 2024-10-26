extends CharacterBody2D
class_name Player
@onready var _animated_sprite = $AnimatedSprite2D
@export var SPEED = 200.0
const MAX_VELOCITY = 50.0
var is_grabbing = false
var ySpeedMultiplier = 1
var xSpeedMultiplier = 1
var grabbed_box : RigidBody2D = null
@export var tilemap: TileMapLayer

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var y_axis := Input.get_axis("ui_up", "ui_down")
	if direction:
		_animated_sprite.play("default")
		velocity.x = direction * SPEED * xSpeedMultiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * xSpeedMultiplier)
	if y_axis:
		velocity.y = y_axis * SPEED * ySpeedMultiplier
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED * ySpeedMultiplier)
	
	if Input.is_action_just_released("Pull"):
				# Release the box when the button is released
		if grabbed_box != null:
			release_box()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collision_crate = collision.get_collider()
		
		if collision_crate.is_in_group("Box"):
			if Input.is_action_pressed("Pull"):
				# Attach the box to the player if it isn't already grabbed
				if grabbed_box == null:
					grab_box(collision_crate, collision.get_normal())
					
		
			
	
	move_and_slide()

func grab_box(collision_crate, collision_normal):
	# Store the reference to the grabbed box
	grabbed_box = collision_crate

	# Attach the box to the player (reparent it to the player node)
	grabbed_box.get_parent().remove_child(grabbed_box)
	self.add_child(grabbed_box)
	grabbed_box.position= Vector2i(0,0)
	# Optional: Offset the box relative to the player based on collision normal
	if collision_normal.x == 0:
		xSpeedMultiplier = 0
		ySpeedMultiplier = 0.5
	if collision_normal.y == 0:
		xSpeedMultiplier = 0.5
		ySpeedMultiplier = 0


func release_box():
	# Detach the box from the player and return it to its original parent
	if grabbed_box != null:
		self.remove_child(grabbed_box)
		var tempPositon = Vector2(int(grabbed_box.global_position.x) % 10, int(grabbed_box.global_position.y) % 10)
		get_parent().add_child(grabbed_box)  # Attach it back to the player's parent or world

		# Optional: Adjust the box position slightly on release
		  # Offset after releasing
		grabbed_box.global_position = global_position + tempPositon

		# Reset multipliers and clear the grabbed box reference
		xSpeedMultiplier = 1.0
		ySpeedMultiplier = 1.0
		grabbed_box = null
