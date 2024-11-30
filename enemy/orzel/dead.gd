extends State

var myowner 
@export var prop_scene: PackedScene = preload("res://props/trash.tscn")

@onready var state_machine = get_parent()
func Enter():
	myowner = state_machine.get_parent()
	await get_tree().create_timer(3.0).timeout
	spawnProps()
	myowner.queue_free()

func PhysicsUpdate(delta:float):
	myowner.SPEED = 0.0
	myowner.velocity = Vector2(0,0)
	
func spawnProps():
	var prop = prop_scene.instantiate()
	prop.type = (randi() % 7 + 1)
	myowner.get_parent().add_child(prop)
	prop.global_position = myowner.global_position
	prop.scale = Vector2(0.1, 0.1)
