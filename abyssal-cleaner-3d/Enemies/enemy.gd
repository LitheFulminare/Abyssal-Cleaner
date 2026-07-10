class_name Enemy extends CharacterBody3D

@onready var state_machine: StateMachine = %StateMachine
@onready var steering_controller: SteeringBehaviourComponent = %SteeringBehaviourComponent

var player: CharacterBody3D
var player_found: bool

func _physics_process(delta: float) -> void:
	if !player_found:
		return
		
	velocity = steering_controller.seek(player.global_position, 5)
	move_and_slide()

func _on_player_detection_area_3d_body_entered(body: Node3D) -> void:
	player = body
	player_found = true
