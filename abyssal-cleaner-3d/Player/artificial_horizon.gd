class_name ArtificialHorizon
extends Control

@export var ah_texture: TextureRect
@export var pivot: Control

var zero_position: float

const pixel_per_degree: int = 3

func _ready() -> void:
	zero_position = ah_texture.position.y

func update_horizon(pitch_rad: float, roll_rad: float) -> void:
	var pitch_deg:float = rad_to_deg(pitch_rad)
	ah_texture.position.y = pitch_deg * pixel_per_degree + zero_position
	
	pivot.rotation = -roll_rad
