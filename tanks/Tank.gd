extends KinematicBody2D

# 子弹 速度 旋转 发射间隔 血量

signal health_changed
signal dead
signal shoot

export (PackedScene) var Bullet

export (int) var speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var health

var velocity = Vector2()
var can_shoot = true
var alive = true

func _ready():
	print(name)
	$GunTimer.wait_time = gun_cooldown
	emit_signal("health_changed",health)
	
func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		
		var dir = Vector2(1,0).rotated($Turret.global_rotation)
		emit_signal("shoot",Bullet,dir,$Turret/Muzzle.global_position)
	pass

func control(delta):
	pass

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)

func explode():
	queue_free()

func take_damage(value):
	health -= value
	if health < 0:
		health = 0
	emit_signal("health_changed",health)
	if health <= 0:
		explode()

func _on_GunTimer_timeout():
	can_shoot = true
