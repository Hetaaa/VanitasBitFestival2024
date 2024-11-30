extends CharacterBody2D

@export var player :CharacterBody2D;
@export var SPEED = 10.0
var health = 100
var hold = false
var knockback_force = 400
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = null;
	if !hold:
		if global_position.x - player.global_position.x >= 0:
			direction = -1
		else:
			direction = 1
		print(direction)
		if direction:
			velocity.x = direction*SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
func get_hit(dmg, dir):
	print("ALLLLLAAAAA")
	health -= dmg
	
	var direction = global_position - dir
	direction = direction.normalized()  # Normalizowanie wektora, aby zachować stałą siłę odpychania
	velocity = direction * knockback_force
	
	
