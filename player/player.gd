extends CharacterBody2D

@onready var col = $col
const SPEED = 300.0


var fanty = 0
var health = 100

var offset_treshold =60;
var current_offset = 0;
var move_hold : bool = false
@onready var hit_area = $Contents/hit_area
@onready var contents = $Contents
@onready var text = $Text
var direction
var no_move : bool = false
var kasa = 0
var strength = 20
signal change_health
signal change_kasa

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
	if !no_move:
		move_and_slide()

func attack():

	for overlap in hit_area.get_overlapping_areas():
		if overlap.is_in_group("hit") and overlap.get_parent().get_parent() != self:
			overlap.get_parent().get_parent().get_hit(20, global_position)
		elif overlap.is_in_group("interact"):
			move_hold = false
			overlap.get_parent().interact()
			no_move = true
			await DialogueManager.dialogue_ended
			no_move = false
	
	
func get_hit(dmg, dir):
		health-=dmg
		change_health.emit(health)
		if global_position.x - dir.x >= 0:
			direction = 1.0
		else:
			direction = -1.0
		if direction:
			var target_velocity_x = direction * 4000
			velocity.x = lerp(velocity.x, target_velocity_x, 1.0)
			velocity.x = clamp(velocity.x, -SPEED, SPEED)
		

func get_thing(what):
	change_kasa.emit(kasa)
	if what == "hotdog":
		if health <=70:
			health +=30
			show_text("+20 HP")
			change_health.emit(health)
		else:
			health = 100
		
	elif what == "piwo":
		strength += 5
		show_text("+5 ATAK")
	elif what == "lombard":
		wymien_fanty()
func wymien_fanty():
	var reward = fanty * randf_range(0.9, 1.4)
	fanty = 0
	reward = int(reward)
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Fant"):
		if body.canDie == 1:
			body.queue_free()

			Global.fanty += 1
			show_text("+1 Fant")


func show_text(tekst):
	text.text = tekst
	text.show()
	await get_tree().create_timer(0.5).timeout
	text.hide()

