extends CharacterBody3D

@export var orientationScreen: OrientationScreen

@export var max_forward_speed := 20.0
@export var max_strafe_speed := 10.0

@export var acceleration := 5.0
@export var deceleration := 3.0

var mouse_direction: Vector2
var center: Vector2
var mouse_distance: float

var forward_speed: float
var strafe_speed: float

func _ready() -> void:
	#center = DisplayServer.screen_get_size() # gets actual screen resolution
	center = get_viewport().get_visible_rect().size
	center = Vector2(center.x/2, center.y/2)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_get_mouse_relative_position()
		mouse_distance = get_viewport().get_mouse_position().distance_to(center)

func _physics_process(delta):
	orientationScreen.update_player_arrow(rotation.y)
	
	# Rotation
	rotation.y -= mouse_direction.x * delta * mouse_distance / 500
	rotation.x -= mouse_direction.y * delta * mouse_distance / 500
	
	# Forward/backward
	var target_forward := 0.0

	if Input.is_action_pressed("Forward"):
		target_forward = max_forward_speed
	elif Input.is_action_pressed("Backwards"):
		target_forward = -max_forward_speed * 0.5

	var forward_rate = acceleration if abs(target_forward) > abs(forward_speed) else deceleration

	forward_speed = move_toward(forward_speed,target_forward,forward_rate * delta)

	# Left/right
	var target_strafe := 0.0

	if Input.is_action_pressed("Right"):
		target_strafe = max_strafe_speed
	elif Input.is_action_pressed("Left"):
		target_strafe = -max_strafe_speed

	var strafe_rate = acceleration if abs(target_strafe) > abs(strafe_speed) else deceleration

	strafe_speed = move_toward(strafe_speed,target_strafe,strafe_rate * delta)

	# Movement relative to submarine rotation
	velocity = -transform.basis.z * forward_speed + transform.basis.x * strafe_speed

	move_and_slide()

func _get_mouse_relative_position() -> void:
	mouse_direction = get_viewport().get_mouse_position() - center
	mouse_direction = mouse_direction.normalized()
