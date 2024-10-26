extends Camera2D

var tilemap: TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tilemap = get_parent().tilemap
	var zoom_vector = get_camera_to_zoom_to_tilemap()
	set_zoom(zoom_vector)
	apply_camera_limits()
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	apply_camera_limits
	
	pass # Replace with function body.
func apply_camera_limits():
	var tilemap_info = get_tilemap_info()
	var level_size = Vector2i(tilemap_info.tile_size * tilemap_info.size)

	set_limit(SIDE_LEFT, 0)
	set_limit(SIDE_TOP, 0)
	set_limit(SIDE_RIGHT, level_size.x)
	set_limit(SIDE_BOTTOM, level_size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func get_camera_to_zoom_to_tilemap():
	var viewport_size = get_viewport().size
	var tilemap_info = get_tilemap_info()
	var level_size = Vector2i(tilemap_info.size * tilemap_info.tile_size)
	var viewport_aspect = float(viewport_size[0])/ viewport_size[1]
	var level_aspect = float(level_size.x)/level_size.y
	var new_zoom = 1.0
	if level_aspect > viewport_aspect:
		new_zoom = float(viewport_size[1]/level_size.y)
	else:
		new_zoom = float(viewport_size[0]/level_size.x)
	return Vector2(new_zoom,new_zoom)
	
func get_tilemap_info():
	var tile_size = tilemap.tile_set.tile_size
	var tilemap_rect = tilemap.get_used_rect()
	var tilemap_size = Vector2i(
		tilemap_rect.end.x - tilemap_rect.position.x,
		tilemap_rect.end.y - tilemap_rect.position.y
	)
	
	return {"size" : tilemap_size, "tile_size" : tile_size} 
