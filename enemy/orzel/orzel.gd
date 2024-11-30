extends CharacterBody2D

@export var player :CharacterBody2D;
@export var SPEED = 10.0
var health = 100
var hold = false
var knockback_force = 100
@onready var col = $col
@onready var state_machine = $State_Machine
@onready var hit_area = $Contents/hit_area
@onready var contents = $Contents
var offset_treshold =60;
var current_offset = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
func get_hit(dmg, dir):
	print(dmg)
	health -= dmg
	if health <= 0:
		state_machine.change_state("Dead")
	else:
		state_machine.change_state("Stun")
	
	
	
	
func attacking():
	for overlap in hit_area.get_overlapping_areas():
		
		if overlap.is_in_group("hit") and overlap.get_parent().get_parent() != self:
			overlap.get_parent().get_parent().get_hit(20, global_position)
