extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_hit():
	print("ALLLLLAAAAA")
	var impulse = Vector2(randf() - 0.5, 1) * 100
	print(impulse)
	apply_central_force(impulse)
