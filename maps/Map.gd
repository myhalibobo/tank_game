extends Node2D

func _ready():
	Input.set_custom_mouse_cursor(load("res://assets/UI/crossair_white.png"),Input.CURSOR_ARROW,Vector2(16,16))
	set_camera_limits()
	
func set_camera_limits():
	var map_limits = $Ground.get_used_rect()
	var cell_size = $Ground.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * cell_size.x
	$Player/Camera2D.limit_right = map_limits.end.x * cell_size.x
	$Player/Camera2D.limit_top = map_limits.position.y * cell_size.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * cell_size.y
	

func _on_Tank_shoot(Bullet,dir,_position,target):
	var bullet = Bullet.instance()
	bullet.start(_position,dir,target)
	add_child(bullet)

func _on_Player_bullet_changed():
	pass # Replace with function body.
