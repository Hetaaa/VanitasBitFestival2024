extends State

var myowner 
@onready var state_machine = get_parent()
var speed_mock = 0.0
func Enter():
	myowner = state_machine.get_parent()
	speed_mock = myowner.SPEED
	myowner.SPEED = 0.0
	myowner.change_animation("hit")
	await get_tree().create_timer(0.3).timeout
	myowner.attacking()
	await get_tree().create_timer(0.6).timeout
	myowner.SPEED = speed_mock
	myowner.change_animation("walking")
	
	if state_machine._get_state_name() != "Dead":
		Transitioned.emit("Attack")
func PhysicsUpdate(delta):
	myowner.SPEED = 0.0
	myowner.velocity = Vector2(0,0)
