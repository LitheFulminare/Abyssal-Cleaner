extends CharacterBody3D

@export var max_forward_speed := 20.0
@export var acceleration := 5.0
@export var deceleration := 3.0

var current_speed := 0.0

func _physics_process(delta):
	var target_speed := 0.0

	if Input.is_action_pressed("Forward"):
		target_speed = max_forward_speed
	elif Input.is_action_pressed("Backwards"):
		target_speed = -max_forward_speed * 0.5

	var rate = acceleration if abs(target_speed) > abs(current_speed) else deceleration

	current_speed = move_toward(current_speed, target_speed, rate * delta)

	velocity = -transform.basis.z * current_speed

	move_and_slide()
