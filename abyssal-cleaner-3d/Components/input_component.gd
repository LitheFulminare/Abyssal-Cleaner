class_name InputComponent extends Node

## Right is [color=AQUAMARINE]+X[/color]; Forward is [color=AQUAMARINE]+Y
var move_dir: Vector2 = Vector2.ZERO
var mouse_position: Vector2
var mouse_direction: Vector2
var mouse_distance: float
#var is_lmb_pressed: bool = false

var screen_center: Vector2
var screen_size: Vector2

signal lmb_pressed

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_get_mouse_relative_position()
	if Input.is_action_pressed("Shoot Left Weapon"):
		#is_lmb_pressed = true
		lmb_pressed.emit()
		_get_mouse_relative_position()
		
	move_dir = Input.get_vector("Left", "Right", "Backwards", "Forward")

func update(window_center: Vector2, window_size: Vector2) -> void:
	screen_center = window_center
	screen_size = window_size

## Gets mouse position relative to the center of the screen and the direction.
func _get_mouse_relative_position() -> void:
	mouse_position = get_viewport().get_mouse_position()
	mouse_distance = mouse_position.distance_to(screen_center)
	mouse_direction = mouse_position - screen_center
	mouse_direction = mouse_direction.normalized()
	mouse_position = clamp(mouse_position, Vector2.ZERO, screen_size)
