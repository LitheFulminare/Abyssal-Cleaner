class_name EnemyIdle extends State

@export var enemy: Enemy

var move_direction: Vector3
var move_speed: float = 2
var wander_time: float
var wait_time: float

func enter() -> void:
	randomize_wander()
	
func exit() -> void:
	return

func update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		#if wait_time > 0:
			#wait_time -= delta
			#move_direction = Vector3.ZERO
		#else:
		randomize_wander()
	
func physics_update(_delta: float) -> void:
	if enemy:
		enemy.move(move_direction, move_speed)

func randomize_wander() -> void:
	move_direction = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 5)
	wait_time = randf_range(1, 5)
