extends KinematicBody2D

# 子弹 速度 旋转 发射间隔 血量

signal health_changed
signal dead
signal shoot
signal bullet_changed

export (PackedScene) var Bullet

export (int) var speed = 0
export (float) var rotation_speed = 1
export (float) var gun_cooldown = 1
export (int) var max_health = 100
export (float, 0, 1.5) var gun_spread = 0.2
export (int) var max_ammo = 10 setget set_ammo

var health
var ammo

var velocity = Vector2()
var can_shoot = true
var alive = true

func _ready():
	print(name)
	$GunTimer.wait_time = gun_cooldown
	health = max_health
	emit_signal("health_changed",health * 100/max_health)
	emit_signal("bullet_changed",ammo * 100/max_ammo)
	
func shoot(target=null , num=1 , separate=0):
	if can_shoot and ammo != 0:
		self.ammo -= 1
		can_shoot = false
		$GunTimer.start()
		emit_signal("bullet_changed",ammo * 100 / max_ammo)
		var dir = Vector2(1,0).rotated($Turret.global_rotation)
		if num > 1:
			for i in range(num):
				var a = -separate + (2*separate)/(num-1) * i
				emit_signal("shoot",Bullet,dir.rotated(a),$Turret/Muzzle.global_position,target)
		else:
			emit_signal("shoot",Bullet,dir ,$Turret/Muzzle.global_position, target)
		$AnimationPlayer.play('muzzle_flash')

func control(delta):
	pass

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)

func explode():
	alive = false
	$Body.hide()
	$Turret.hide()
	$Explosions.show()
	$Explosions.play("explosion")

func heal(value):
	health += value
	clamp(health,0,max_health)
	emit_signal("health_changed",health * 100/max_health)

func take_damage(value):
	health -= value
	clamp(health,0,max_health)
	print(health * 100/max_health)
	emit_signal("health_changed",health * 100/max_health)
	if health == 0:
		explode()

func _on_GunTimer_timeout():
	can_shoot = true

func _on_Explosions_animation_finished():
	queue_free()
	
func set_ammo(value):
	ammo = value
	clamp(ammo,0,max_ammo)
	emit_signal("bullet_changed",ammo * 100 / max_ammo)
