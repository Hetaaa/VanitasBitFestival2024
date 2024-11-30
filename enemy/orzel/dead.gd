extends State

var myowner 
@onready var state_machine = get_parent()
func Enter():
	myowner = state_machine.get_parent()
	await get_tree().create_timer(3.0).timeout
	myowner.queue_free()

func PhysicsUpdate(delta:float):
	myowner.SPEED = 0.0
	myowner.velocity = Vector2(0,0)
