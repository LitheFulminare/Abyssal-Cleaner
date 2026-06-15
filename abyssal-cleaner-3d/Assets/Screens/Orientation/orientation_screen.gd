class_name OrientationScreen
extends Sprite3D

@export var playerArrow: Sprite3D
@export var artificial_horizon: ArtificialHorizon

func update_player_arrow(new_rotation: float) -> void:
	playerArrow.rotation.z = new_rotation

func update_artificial_horizon(pitch_rad: float) -> void:
	artificial_horizon.update_horizon(pitch_rad)
