extends CharacterBody2D

@onready var col = $col
const SPEED = 300.0
var offset_treshold =60;
var current_offset = 0;
var move_hold : bool = false
@onready var hit_area = $hit_area
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("up"):
		if current_offset < offset_treshold:
			col.global_position.y += 1
			current_offset +=1
	elif Input.is_action_pressed("down"):
		if current_offset > 0:

			col.global_position.y -= 1
			current_offset -= 1
	if  Input.is_action_just_pressed("attack"):
		attack()
	move_and_slide()

func attack():
	for overlap in hit_area.get_overlapping_areas():
		if overlap.is_in_group("hit"):
			overlap.get_parent().get_hit()
	
