extends Area2D

var velocity = Vector2() 
export (float) var move_speed = 200
export (float) var lift_time = 2
export (float) var damage = 10
export (float) var stree_force = 0
var acceleration = Vector2()
var target = null

func _ready():
	$Lifttime.wait_time = lift_time
	$Lifttime.start()

func start(_position,dir:Vector2,_target = null):
	position = _position
	rotation = dir.angle()
	velocity = dir * move_speed
	target = _target

func seek():
	var desired = (target.position - position).normalized() * move_speed
	var stree = (desired - velocity).normalized() * stree_force
	return stree
	pass
	
func _process(delta):
	if target:
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(move_speed)
		rotation = velocity.angle()
	position += velocity * delta

func _on_Lifttime_timeout():
	explode()

func explode():
	velocity = Vector2()
	acceleration = Vector2()
	$Sprite.visible = false
	$Explosions.visible = true
	$Explosions.play("smoke")

func _on_Bullet_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	explode()

func _on_Explosions_animation_finished():
	queue_free()
