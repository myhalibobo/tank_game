extends CanvasLayer

var red_texture = preload("res://assets/UI/barHorizontal_red_mid 200.png")
var yellow_texture = preload("res://assets/UI/barHorizontal_yellow_mid 200.png")
var green_texture = preload("res://assets/UI/barHorizontal_green_mid 200.png")

func _ready():
	pass # Replace with function body.

func update_BloodProgress(value):
	if value <= 20:
		$MarginContainer/HBoxContainer/BloodProgress.texture_progress = red_texture	
	elif value <= 60:
		$MarginContainer/HBoxContainer/BloodProgress.texture_progress = yellow_texture
	$Tween.interpolate_property($MarginContainer/HBoxContainer/BloodProgress,"value",$MarginContainer/HBoxContainer/BloodProgress.value,value,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()

func update_AmmoProgress(value):
	$Tween.interpolate_property($MarginContainer/HBoxContainer/AmmoProgress,"value",$MarginContainer/HBoxContainer/AmmoProgress.value,value,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()