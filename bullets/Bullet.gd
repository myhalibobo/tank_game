extends Area2D

var velocity = Vector2() 
export (float) var move_speed = 200
export (float) var lift_time = 2
export (float) var damage = 10

func _ready():
	$Lifttime.wait_time = lift_time
	$Lifttime.start()
	print("wait_time:",lift_time)

func start(_position,dir:Vector2):
	position = _position
	rotation = dir.angle()
	velocity = dir * move_speed
	
func _process(delta):
	position += velocity * delta

func _on_Lifttime_timeout():
	explode()

func explode():
	velocity = Vector2()
	$Sprite.visible = false
	$Explosions.visible = true
	$Explosions.play("smoke")

func _on_Bullet_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	explode()

func _on_Explosions_animation_finished():
	queue_free()
