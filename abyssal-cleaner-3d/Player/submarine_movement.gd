extends CharacterBody3D

@export var orientationScreen: OrientationScreen

@export var max_forward_speed := 20.0
@export var max_strafe_speed := 10.0

@export var acceleration := 5.0
@export var deceleration := 3.0

var mouse_direction: Vector2
var center: Vector2
var mouse_distance: float
var mouse_position: Vector2
var screen_size: Vector2

var forward_speed: float
var strafe_speed: float

var yaw_rad: float
var pitch: float

func _ready() -> void:
	#center = DisplayServer.screen_get_size() # gets actual screen resolution
	calculate_center()
	get_tree().get_root().size_changed.connect(calculate_center)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_position = get_viewport().get_mouse_position()
		_get_mouse_relative_position()
		mouse_position = clamp(mouse_position, Vector2.ZERO, screen_size)
		mouse_distance = get_viewport().get_mouse_position().distance_to(center)

func _physics_process(delta:float) -> void:
	var forward: Vector3 = -global_basis.z
	yaw_rad = atan2(forward.x, forward.z)
	orientationScreen.update_player_arrow(yaw_rad)
	
	#var up = global_basis.y
	#var projected_up = (up - up.project(forward)).normalized()
	#var projected_world_up = (Vector3.UP - Vector3.UP.project(forward)).normalized()
	#var roll = projected_up.signed_angle_to(projected_world_up,forward)
	
	
	# Rotation
	var offset: Vector2 = mouse_position - center

	var normalized_offset: Vector2 = Vector2(offset.x / center.x, offset.y / center.y)
	
	var yaw_amount: float = -normalized_offset.x * delta # * turning speed
	var pitch_amount: float = -normalized_offset.y * delta # * turning speed
	
	#var yaw_amount = -normalized_offset.x * delta * mouse_distance / 500.0
	#var pitch_amount = -normalized_offset.y * delta * mouse_distance / 500.0
	
	var yaw_quat: Quaternion = Quaternion(global_basis.y, yaw_amount)
	var pitch_quat: Quaternion = Quaternion(global_basis.x, pitch_amount)

	quaternion = yaw_quat * pitch_quat * quaternion
	
	var submarine_up: Vector3 = global_basis.y
	var world_up: Vector3 = Vector3.UP

	# Project both ups onto the plane perpendicular to forward
	var projected_sub_up: Vector3 = (submarine_up - submarine_up.project(forward)).normalized()
	var projected_world_up: Vector3 = (world_up - world_up.project(forward)).normalized()

	# 1 = horizontal, 0 = vertical
	#var level_factor = 1.0 - abs(forward.y)
	var level_factor: float = 1.0 - pow(abs(forward.y), 2)

	var roll_angle: float = projected_sub_up.signed_angle_to(
	projected_world_up,
	forward
	)
	
	var auto_level_speed: float = 3
	var correction: float = roll_angle * auto_level_speed * level_factor * delta

	var roll_quat: Quaternion = Quaternion(forward, correction)
	quaternion = roll_quat * quaternion
	
	orientationScreen.update_artificial_horizon(asin(forward.y), roll_angle)
	
	# Causes gimbal lock
	#rotation.y -= mouse_direction.x * delta * mouse_distance / 500
	#rotation.x -= mouse_direction.y * delta * mouse_distance / 500
	
	# Forward/backward
	var target_forward := 0.0

	if Input.is_action_pressed("Forward"):
		target_forward = max_forward_speed
	elif Input.is_action_pressed("Backwards"):
		target_forward = -max_forward_speed * 0.5

	var forward_rate:float = acceleration if abs(target_forward) > abs(forward_speed) else deceleration

	forward_speed = move_toward(forward_speed,target_forward,forward_rate * delta)

	# Left/right
	var target_strafe := 0.0

	if Input.is_action_pressed("Right"):
		target_strafe = max_strafe_speed
	elif Input.is_action_pressed("Left"):
		target_strafe = -max_strafe_speed

	var strafe_rate: float = acceleration if abs(target_strafe) > abs(strafe_speed) else deceleration

	strafe_speed = move_toward(strafe_speed,target_strafe,strafe_rate * delta)

	# Movement relative to submarine rotation
	velocity = -transform.basis.z * forward_speed + transform.basis.x * strafe_speed

	move_and_slide()

func calculate_center() -> void:
	screen_size = get_viewport().get_visible_rect().size
	center = Vector2(screen_size.x/2, screen_size.y/2)

func _get_mouse_relative_position() -> void:
	mouse_direction = mouse_position - center
	mouse_direction = mouse_direction.normalized()
