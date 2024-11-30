extends State

var myowner 
@onready var state_machine = get_parent()
var similiar_offset : bool = false
# Called when the node enters the scene tree for the first time.
func Enter():
	myowner = state_machine.get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func PhysicsUpdate(delta):
	if myowner.global_position:
		var direction = null;
		
		if myowner.global_position.x - myowner.player.global_position.x >= 0:
			direction = -1
		else:
			direction = 1
		if direction:
			var target_velocity_x = direction * myowner.SPEED
			myowner.velocity.x = lerp(myowner.velocity.x, target_velocity_x, 0.1)  # 0.1 to współczynnik "gładkości"
			myowner.velocity.x = clamp(myowner.velocity.x, -myowner.SPEED, myowner.SPEED)
			if myowner.contents.scale.x !=direction:
				myowner.contents.scale.x = direction
			if direction == 0:
				myowner.velocity.x = move_toward(myowner.velocity.x, 0, myowner.SPEED * delta)
			
	if myowner.global_position.distance_to(myowner.player.global_position) < 280.0 and similiar_offset :
		Transitioned.emit("Hit")


func _on_change_offset_timeout() -> void:
	if state_machine._get_state_name() == "Attack":
		var player_offset = myowner.player.current_offset
		if myowner.current_offset >player_offset:
			myowner.current_offset -=1
			myowner.col.position.y -=1
		elif myowner.current_offset <player_offset:
			myowner.current_offset += 1
			myowner.col.position.y += 1
		if myowner.current_offset - player_offset <=20:
			similiar_offset = true
		else: 
			similiar_offset = false
