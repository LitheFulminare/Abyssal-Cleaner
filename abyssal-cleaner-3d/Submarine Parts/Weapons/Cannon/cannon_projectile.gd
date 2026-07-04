class_name Cannon_Projectile extends Projectile

var lifetime: float

func _ready() -> void:
	disable()

func _process(delta: float) -> void:
	if disabled:
		return
	
	lifetime += delta
	if lifetime > lifespan:
		lifetime = 0.0
		disable()
	
	position += direction * speed * delta

func _on_body_entered(body: Node3D) -> void:
	# if body is Enemy ...
	return
