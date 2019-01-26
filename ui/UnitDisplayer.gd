extends Node2D

var red_texture = preload("res://assets/UI/barHorizontal_red_mid 200.png")
var yellow_texture = preload("res://assets/UI/barHorizontal_yellow_mid 200.png")
var green_texture = preload("res://assets/UI/barHorizontal_green_mid 200.png")

func _ready():
	pass # Replace with function body.

func _process(delta):
	global_rotation = 0.0
	
func update_BloodProgress(value):
	print(value)
	if value <= 20:
		$HpProgress.texture_progress = red_texture	
	elif value <= 60:
		$HpProgress.texture_progress = yellow_texture
	$Tween.interpolate_property($HpProgress,"value",$HpProgress.value,value,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()