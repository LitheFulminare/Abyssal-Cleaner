class_name Cannon_Projectile extends Projectile

var lifetime: float

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if disabled:
		return
	
	lifetime += delta
	if lifetime > lifespan:
		lifetime = 0.0
		expired.emit(self)
	
	position += direction * speed * delta

func _on_body_entered(body: Node3D) -> void:
	if disabled: 
		return
	
	# if body is Enemy ...
	return
