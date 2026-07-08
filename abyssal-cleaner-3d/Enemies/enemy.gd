class_name Enemy extends CharacterBody3D

@onready var state_machine: StateMachine = %StateMachine
#@onready var movement_component: MovementComponent = %MovementComponent

func _physics_process(delta: float) -> void:
	return
	#movement_component.update(state_machine.current_state.get)

func move(direction: Vector3, speed: float) -> void:
	velocity = direction * speed
	move_and_slide()
