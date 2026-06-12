extends CharacterBody3D

@export var max_forward_speed := 20.0
@export var max_strafe_speed := 10.0

@export var acceleration := 5.0
@export var deceleration := 3.0

var forward_speed := 0.0
var strafe_speed := 0.0

func _physics_process(delta):
	# Forward/backward
	var target_forward := 0.0

	if Input.is_action_pressed("Forward"):
		target_forward = max_forward_speed
	elif Input.is_action_pressed("Backwards"):
		target_forward = -max_forward_speed * 0.5

	var forward_rate = acceleration if abs(target_forward) > abs(forward_speed) else deceleration

	forward_speed = move_toward(
	forward_speed,
	target_forward,
	forward_rate * delta
	)

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
