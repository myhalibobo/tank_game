tool
extends Area2D

enum Items {health,ammo}
export(Items) var type = Items.health setget update_type
var range_vec = Vector2(50,100)

var textureList = [preload("res://assets/effects/wrench_white.png"),preload("res://assets/effects/ammo_machinegun.png")]

func _ready():
	$wrench_white.texture = textureList[type]
#	$AnimationPlayer.play("ani")

func _on_PickUp_body_entered(body):
	match type:
		Items.health:
			if body.has_method("heal"):
				body.heal(rand_range(range_vec.x,range_vec.y))
		Items.ammo:
			body.ammo += rand_range(range_vec.x,range_vec.y)
	queue_free()

func update_type(_type):
	print(type)
	type = _type
	$wrench_white.texture = textureList[type]