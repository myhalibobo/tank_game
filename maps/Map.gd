extends Node2D

func _ready():
	set_camera_limits()
	
func set_camera_limits():
	var map_limits = $Ground.get_used_rect()
	var cell_size = $Ground.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * cell_size.x
	$Player/Camera2D.limit_right = map_limits.end.x * cell_size.x
	$Player/Camera2D.limit_top = map_limits.position.y * cell_size.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * cell_size.y
	