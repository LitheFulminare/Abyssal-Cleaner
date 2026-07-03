class_name Player extends CharacterBody3D

@onready var input_component: InputComponent = %InputComponent
@onready var weapon_component: WeaponComponent = %WeaponComponent
@onready var movement_component: MovementComponent = %MovementComponent


@onready var orientation_screen: OrientationScreen = %"Orientation Screen"
@onready var left_screen: LeftScreen = %"Left Screen"

var center: Vector2
var screen_size: Vector2

#var weapon_scene: PackedScene = preload("res://Submarine Parts/Weapons/Cannon/cannon.tscn")
@onready var left_weapon: Weapon = %Cannon

func _ready() -> void:
	input_component.lmb_pressed.connect(weapon_component.shoot)
	
	initialize_weapon()
	calculate_center()
	# Recalculates the center when the window size changes
	get_tree().get_root().size_changed.connect(calculate_center)

func _physics_process(delta:float) -> void:
	input_component.update(center, screen_size)
	movement_component.update(input_component.mouse_position, center, delta)
	
	# HUD
	var forward: Vector3 = global_basis.z
	orientation_screen.update_screen(atan2(forward.x, forward.z), 
		asin(forward.y), movement_component.roll_angle)
	left_screen.update_display(velocity.length())

func initialize_weapon() -> void:
	#var weapon: Weapon = weapon_scene.instantiate()
	#add_child(weapon)
	weapon_component.weapon = left_weapon
	weapon_component.weapon.initialize()
	

func calculate_center() -> void:
	#center = DisplayServer.screen_get_size() # gets actual screen resolution
	screen_size = get_viewport().get_visible_rect().size
	center = Vector2(screen_size.x/2, screen_size.y/2)
