extends Area2D

enum ItemType {health,ammo}
export(ItemType) var type = ItemType.health
var range_vec = Vector2(50,100)

func _ready():
	pass # Replace with function body.


func _on_PickUp_body_entered(body):
	if type == ItemType.health:
		if body.has_method("heal"):
			body.heal(rand_range(range_vec.x,range_vec.y))
	else:
		pass
	queue_free()