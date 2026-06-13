class_name OrientationScreen
extends Sprite3D

@export var playerArrow: Sprite3D

func update_player_arrow(new_rotation: float) -> void:
	playerArrow.rotation.z = new_rotation
