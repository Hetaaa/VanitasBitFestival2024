extends State
var anti_speed = 50
var myowner 
@onready var state_machine = get_parent()
@onready var stun_timer = $stun_timer
func Enter():
	myowner = state_machine.get_parent()
	stun_timer.start()
func PhysicsUpdate(delta):
	if myowner:
		var direction = null;
		
		if myowner.global_position.x - myowner.player.global_position.x >= 0:
			direction = 1.0
		else:
			direction = -1.0
		if direction:
			var target_velocity_x = direction * 3000
			myowner.velocity.x = lerp(myowner.velocity.x, target_velocity_x, 1.0)
			myowner.velocity.x = clamp(myowner.velocity.x, -myowner.SPEED, myowner.SPEED)


func _on_stun_timer_timeout() -> void:
	
	if state_machine._get_state_name() == "Stun":
		if myowner.health <= 0:
			Transitioned.emit("Dead")
		else:
			Transitioned.emit("Attack")
