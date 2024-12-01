extends CharacterBody2D

@onready var col = $col
var SPEED = 300.0



var offset_treshold =60;
var current_offset = 0;
var move_hold : bool = false
@onready var hit_area = $Contents/hit_area
@onready var contents = $Contents
@onready var text = $Text
var direction
var no_move : bool = false

var isattacking = false
signal change_health
signal change_kasa
signal player_dead
func _ready() -> void:
	money.player = self

	change_health.emit()
	change_kasa.emit()
func _physics_process(delta: float) -> void:

	print (Global.health, Global.kasa, Global.fanty, Global.fanty)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if !no_move:
		direction = Input.get_axis("left", "right")
		if direction:
			if !isattacking:
				contents.get_child(0).play("walk");
			var target_velocity = direction * SPEED
			velocity.x = lerp(velocity.x, target_velocity, 0.2)  # 0.1 to współczynnik "gładkości"
			velocity.x = clamp(velocity.x, -SPEED, SPEED)

			if contents.scale.x !=direction:
				contents.scale.x = direction
		else:
			velocity.x = lerp(velocity.x, 0.0, 0.2)
			if !isattacking:
				contents.get_child(0).play("idle");
		
		if  Input.is_action_just_pressed("attack"):
			attack()
		if !no_move:
			move_and_slide()


func attack():
	contents.get_child(0).play("hit");
	isattacking = true
	no_move = true
	for overlap in hit_area.get_overlapping_areas():
		if overlap.is_in_group("hit") and overlap.get_parent().get_parent() != self:
			
			
			overlap.get_parent().get_parent().get_hit(20, global_position)
			
			
			
		elif overlap.is_in_group("interact"):
			move_hold = false
			overlap.get_parent().interact()
			no_move = true
			await DialogueManager.dialogue_ended
			no_move = false
	await get_tree().create_timer(0.5).timeout
	no_move = false
	
	
func get_hit(dmg, dir):
		Global.health-=dmg
		change_health.emit(Global.health)
		if Global.health <= 0:
			die()
			return
		
		if global_position.x - dir.x >= 0:
			direction = 1.0
		else:
			direction = -1.0
		if direction:
			var target_velocity_x = direction * 4000
			velocity.x = lerp(velocity.x, target_velocity_x, 1.0)
			velocity.x = clamp(velocity.x, -SPEED, SPEED)
		

func get_thing(what):
	change_kasa.emit(Global.kasa)
	if what == "hotdog":
		if Global.health <=70:
			Global.kasa-=10
			Global.health +=30
			show_text("+20 HP")
			change_health.emit(Global.health)
		else:
			Global.kasa-=10
			Global.health = 100
			show_text("+20 HP")
			change_health.emit(Global.health)
			
	elif what == "piwo":
		Global.sila += 5
		Global.kasa -= 12
		show_text("+5 ATAK")
	elif what == "lombard":
		wymien_fanty()
	elif what == "auto":
		get_tree().change_scene_to_file("res://koniec.tscn")
	change_kasa.emit(Global.kasa)
func wymien_fanty():
	var reward = Global.fanty * randf_range(0.9, 1.4)
	Global.fanty = 0
	reward = int(reward)
	Global.kasa += reward
	show_text("+"+str(reward)+"zł")

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


func die():
	player_dead.emit()

	no_move = true

	move_hold = true
	contents.rotation = -PI/2;
	contents.position.y = 150;
	
	SPEED = 0.0
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://main_window.tscn")
	Global.health = 100
	Global.kasa = 20
	Global.sila = 20
	Global.fanty = 0
	Global.przystanek = 1
	SPEED = 300


func _on_animated_sprite_2d_animation_finished() -> void:
	if isattacking:
		isattacking = false
