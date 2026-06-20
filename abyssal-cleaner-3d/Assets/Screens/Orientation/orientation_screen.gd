class_name OrientationScreen
extends Sprite3D

@export var playerArrow: Sprite3D
@export var artificial_horizon: ArtificialHorizon
@export var pitch_label: Label3D
@export var roll_label: Label3D
@export var heading_label: Label3D

## Updates the numbers on the right screen, artificial horizon roll and pitch, and the compass direction.
func update_screen(yaw_rad: float, pitch_rad: float, roll_rad: float) -> void:
	playerArrow.rotation.z = yaw_rad
	artificial_horizon.update_horizon(pitch_rad, roll_rad)
	
	pitch_label.text = str(int(rad_to_deg(pitch_rad)))
	roll_label.text = str(int(rad_to_deg(roll_rad)))
	heading_label.text = str(int(rad_to_deg(-yaw_rad)))
