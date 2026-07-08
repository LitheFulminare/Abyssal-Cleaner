class_name MovementComponent extends Node

var body: CharacterBody3D

@export var max_forward_speed := 20.0
@export var max_strafe_speed := 10.0

@export var acceleration := 5.0
@export var deceleration := 3.0

var forward_speed: float
var strafe_speed: float
var roll_angle: float

func _ready() -> void:
	var parent_node: Node = get_parent()
	if parent_node is CharacterBody3D:
		body = parent_node
	else:
		printerr("Parent of MovementComponent should be CharacterBody3D, but is " + parent_node.get_class())

func update(move_dir: Vector2, look_pointer_pos: Vector2, center: Vector2, delta: float) -> void:
	if body == null:
		return
	
	var forward: Vector3 = -body.global_basis.z
	
	#region Rotation
	
	# Make turning speed independent of screen size
	var look_dir: Vector2 = look_pointer_pos - center
	var normalized_look_dir: Vector2 = Vector2(look_dir.x / center.x, look_dir.y / center.y)
	
	var yaw_amount: float = -normalized_look_dir.x * delta # * turning speed
	var pitch_amount: float = -normalized_look_dir.y * delta # * turning speed
	
	var yaw_quat: Quaternion = Quaternion(body.global_basis.y, yaw_amount)
	var pitch_quat: Quaternion = Quaternion(body.global_basis.x, pitch_amount)

	body.quaternion = yaw_quat * pitch_quat * body.quaternion
	
	var submarine_up: Vector3 = body.global_basis.y
	var world_up: Vector3 = Vector3.UP

	# Project both ups onto the plane perpendicular to forward
	var projected_sub_up: Vector3 = (submarine_up - submarine_up.project(forward)).normalized()
	var projected_world_up: Vector3 = (world_up - world_up.project(forward)).normalized()

	# 1 = horizontal, 0 = vertical
	var level_factor: float = 1.0 - pow(abs(forward.y), 2)

	roll_angle = projected_sub_up.signed_angle_to(projected_world_up,forward)
	
	var auto_level_speed: float = 3
	var correction: float = roll_angle * auto_level_speed * level_factor * delta

	var roll_quat: Quaternion = Quaternion(forward, correction)
	body.quaternion = roll_quat * body.quaternion
	
	# Causes gimbal lock
	#rotation.y -= mouse_direction.x * delta * mouse_distance / 500
	#rotation.x -= mouse_direction.y * delta * mouse_distance / 500
	
	#endregion
	
	#region Strafe Movement
	# Forward/backward
	var target_forward := 0.0

	if move_dir.y == 1:
		target_forward = max_forward_speed
	elif move_dir.y == -1:
		target_forward = -max_forward_speed * 0.5

	var forward_rate: float = acceleration if abs(target_forward) > abs(forward_speed) else deceleration

	forward_speed = move_toward(forward_speed, target_forward, forward_rate * delta)

	# Left/right
	var target_strafe := 0.0

	if Input.is_action_pressed("Right"):
		target_strafe = max_strafe_speed
	elif Input.is_action_pressed("Left"):
		target_strafe = -max_strafe_speed

	var strafe_rate: float = acceleration if abs(target_strafe) > abs(strafe_speed) else deceleration

	strafe_speed = move_toward(strafe_speed,target_strafe,strafe_rate * delta)

	#endregion

	# Movement relative to submarine rotation
	body.velocity = -body.transform.basis.z * forward_speed + body.transform.basis.x * strafe_speed

	body.move_and_slide()
