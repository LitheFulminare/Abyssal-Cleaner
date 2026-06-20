class_name LeftScreen
extends Sprite3D

@export var speed_needle: Sprite3D
@export var speed_label: Label3D

func update_display(speed: float) -> void:
	speed_label.text = str(int(speed))
	#                 ang min, ang max, current speed, max speed on the gauge
	speed_needle.rotation_degrees.z = lerp(45, -225, speed / 45)
