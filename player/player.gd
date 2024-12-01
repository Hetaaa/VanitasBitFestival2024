extends CharacterBody2D

@onready var col = $col
const SPEED = 300.0

var offset_treshold =60;
var current_offset = 0;
var move_hold : bool = false
@onready var hit_area = $Contents/hit_area
@onready var contents = $Contents
var direction

func _ready() -> void:
	money.player = self
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction:
		var target_velocity = direction * SPEED
		velocity.x = lerp(velocity.x, target_velocity, 0.2)  # 0.1 to współczynnik "gładkości"
		velocity.x = clamp(velocity.x, -SPEED, SPEED)

		if contents.scale.x !=direction:
			contents.scale.x = direction
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	
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
		if overlap.is_in_group("hit") and overlap.get_parent().get_parent() != self:
			overlap.get_parent().get_parent().get_hit(20, global_position)
		elif overlap.is_in_group("interact"):
			print('dawdaw')
			overlap.get_parent().interact()

	
	
func get_hit(dmg, dir):
	
		if global_position.x - dir.x >= 0:
			direction = 1.0
		else:
			direction = -1.0
		if direction:
			var target_velocity_x = direction * 4000
			velocity.x = lerp(velocity.x, target_velocity_x, 1.0)
			velocity.x = clamp(velocity.x, -SPEED, SPEED)


func get_thing():
	print("I got a thing!")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Fant"):
		if body.canDie == 1:
			body.queue_free()
			Global.fanty += 1
