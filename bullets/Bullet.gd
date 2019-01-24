extends Area2D

var velocity = Vector2() 
export (float) var move_speed = 200
export (float) var lift_time = 2

func _ready():
	$Lifttime.wait_time = lift_time

func start(_position,dir:Vector2):
	position = _position
	rotation = dir.angle()
	velocity = dir * move_speed
	
func _process(delta):
	position += velocity * delta

func _on_Lifttime_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.has_method("damage_take"):
		body.damage_take()
	queue_free()
