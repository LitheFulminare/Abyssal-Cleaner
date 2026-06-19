class_name OrientationScreen
extends Sprite3D

@export var playerArrow: Sprite3D
@export var artificial_horizon: ArtificialHorizon
@export var pitch_label: Label3D
@export var roll_label: Label3D
@export var heading_label: Label3D

func update_player_arrow(yaw_rad: float) -> void:
	playerArrow.rotation.z = yaw_rad
	heading_label.text = str(int(rad_to_deg(-yaw_rad)))

func update_artificial_horizon(pitch_rad: float, roll_rad: float) -> void:
	artificial_horizon.update_horizon(pitch_rad, roll_rad)
	pitch_label.text = str(int(rad_to_deg(pitch_rad)))
	roll_label.text = str(int(rad_to_deg(roll_rad)))
