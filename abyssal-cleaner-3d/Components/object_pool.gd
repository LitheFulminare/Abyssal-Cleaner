class_name ObjectPool extends Node

var _pool: Array[Node] = []
var object: PackedScene

func create_pool(node_scene:PackedScene, ammount: int) -> void:
	object = node_scene
	
	for i in ammount:
		var obj: Node = object.instantiate()
		add_child(obj)
		_pool.append(obj)
