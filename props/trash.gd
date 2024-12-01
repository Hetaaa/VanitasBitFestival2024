
extends RigidBody2D
@onready var sprite = $Sprite2D
@onready var timer = $Timer
var type = 1

var canDie = 0
# Called when the node enters the scene tree for the first time.
var czekolada: Texture2D = preload("res://props/sprites/czekolada.png")
var kasa: Texture2D = preload("res://props/sprites/kasa.png")
var piwo: Texture2D = preload("res://props/sprites/piwo.png")
var portfel: Texture2D = preload("res://props/sprites/portfel.png")
var tablet: Texture2D = preload("res://props/sprites/tablet.png")
var zegarek: Texture2D = preload("res://props/sprites/zegarek.png")

func _ready() -> void:
	
	match type:
		1:
			sprite.texture = czekolada
			var cczekolada = preload("res://props/shapes/czekolada.tscn")
			var c = cczekolada.instantiate()
			add_child(c) 
			c.scale = Vector2(0.25, 0.25)
		2:
			sprite.texture = kasa
			var ckasa = preload("res://props/shapes/kasa.tscn")
			var c = ckasa.instantiate()
			add_child(c)
			c.scale = Vector2(0.25, 0.25)
		3:
			sprite.texture = piwo
			var cpiwo = preload("res://props/shapes/piwo.tscn")
			var c = cpiwo.instantiate()
			add_child(c)
			c.scale = Vector2(0.25, 0.25)
		4:
			sprite.texture = portfel
			var cportfel = preload("res://props/shapes/portfel.tscn")
			var c = cportfel.instantiate()
			add_child(c)
			c.scale = Vector2(0.25, 0.25)
		5:
			sprite.texture = tablet
			var ctablet = preload("res://props/shapes/tablet.tscn")
			var c = ctablet.instantiate()
			add_child(c)
			c.scale = Vector2(0.25, 0.25)
		6:	
			sprite.texture = zegarek
			var czegarek = preload("res://props/shapes/zegarek.tscn")
			var c = czegarek.instantiate()
			add_child(c)
			c.scale = Vector2(0.25, 0.25)
	apply_random_force()
	apply_random_rotation()
	timer.start(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_random_force():
	# Generate a random angle (0 to 2 * PI)
	var angle = randf_range(1.25* PI, 1.75*PI)
	var direction = Vector2(cos(angle), sin(angle))
	
	# Define the magnitude of the force
	var force_magnitude = randf_range(700, 1000)  # Adjust as needed
	var force = direction * force_magnitude
	
	# Apply the force at the center of the body
	apply_central_impulse(force)

func apply_random_rotation():
	# Generate a random torque (rotation force)
	var torque = randf_range(-100, 100)  # Adjust as needed
	
	# Apply the torque (one-time)
	apply_torque_impulse(torque)
	



func _on_timer_timeout() -> void:
	canDie = 1
