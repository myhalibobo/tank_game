extends "Tank.gd"

onready var parent = get_parent()
export (int) var detect_radius = 200
export (float) var turret_speed = 1
onready var Area2D_DetectRadiuls :Area2D = $Area2D_DetectRadiuls
var detected_tank

var max_speed

func _ready():
	max_speed = speed
	$Area2D_DetectRadiuls/CollisionShape2D.shape.radius = detect_radius
	pass

func control(delta):
	if parent is PathFollow2D:
		if $LookAhead1.is_colliding() or $LookAhead2.is_colliding():
			speed = lerp(speed , 0 , 0.05)
		else:
			speed = lerp(speed , max_speed , 0.05)
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	pass

func _process(delta):
	if detected_tank:
		var cur_direction = Vector2(1,0).rotated($Turret.global_rotation)
		var target_dir :Vector2= (detected_tank.global_position - global_position).normalized()
		$Turret.global_rotation = cur_direction.linear_interpolate(target_dir,turret_speed * delta).angle()
		if cur_direction.dot(target_dir) > 0.9:
			shoot(detected_tank,3,gun_spread)
	pass

func _on_Area2D_DetectRadiuls_body_entered(body):
	if body.name == "Player":
		detected_tank = body
	pass # Replace with function body.


func _on_Area2D_DetectRadiuls_body_exited(body):
	detected_tank = null
