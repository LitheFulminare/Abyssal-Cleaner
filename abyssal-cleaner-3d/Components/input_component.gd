class_name InputComponent extends Node

var move_dir: Vector2 = Vector2.ZERO
var is_lmb_pressed: bool = false

signal lmb_pressed()

func update() -> void:
	if Input.is_action_pressed("Shoot Left Weapon"):
		is_lmb_pressed = true
		lmb_pressed.emit()
