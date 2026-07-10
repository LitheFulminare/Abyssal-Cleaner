# Code made using mainly this video:
# https://youtu.be/LDCbUmvsV-A?si=9mM9X8LZHfIwewLS
class_name SteeringBehaviourComponent extends Node

@export var body: CharacterBody3D
@export var max_steer_force: float = 5
@export var arrival_radius: float = 5

func seek(target: Vector3, max_speed: float) -> Vector3:
	var desired_velocity := (target - body.global_position) * max_speed
	
	var steering := (desired_velocity - body.velocity).limit_length(max_steer_force)
	return steering

func flee(target: Vector3, max_speed: float) -> Vector3:
	var desired_velocity := (body.global_position - target) * max_speed
	
	var steering := (desired_velocity - body.velocity).limit_length(max_steer_force)
	return steering

func arrival(target: Vector3, max_speed: float) -> Vector3:
	var direction: Vector3= target - body.global_position
	var desired_velocity: Vector3 = direction.normalized() * max_speed
	var distance: float = direction.length()
	
	var speed: float = min(distance, max_speed)
	desired_velocity = desired_velocity.normalized() * speed
	if speed < max_speed * 0.01:
		desired_velocity = Vector3.ZERO
	
	# Basically a magic number?? I have to check the tutorial later on, this part is a bit confusing
	var time_factor: float = 0.1
	
	var steering: Vector3 = ((desired_velocity - body.velocity)/time_factor).limit_length(max_steer_force)
	return steering
	
	#var direction := target - body.global_position
	#var desired_velocity := direction * max_speed
	#
	#var distance: float = direction.length()
	#if distance < arrival_radius:
		#desired_velocity *= (distance / arrival_radius)
	#
	#var steering := (desired_velocity - body.velocity).limit_length(max_steer_force)
	#return steering

## Seeks toward the position the target will be.
func persue(target: CharacterBody3D, max_speed: float) -> Vector3:
	var prediction: Vector3 = predict_target(target)
	
	return seek(prediction, max_speed)
	
## Flees from the predicted position (opposite of persue).
func Evade(target: CharacterBody3D, max_speed: float) -> Vector3:
	var prediction: Vector3 = predict_target(target)
	
	return flee(prediction, max_speed)

func predict_target(target:CharacterBody3D) -> Vector3:
	var distance := (target.global_position - body.global_position).length()
	var predict_time: float = min(distance / body.velocity.length(), 1)
	
	var prediction: Vector3 = target.global_position + target.velocity * predict_time
	return prediction
