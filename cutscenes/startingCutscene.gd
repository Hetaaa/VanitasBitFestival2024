extends Node2D

@onready var frame1 = $frame1
@onready var frame2 = $frame2
@onready var frame3 = $frame3
@onready var frame4 = $frame4
var tween

var transition_duration = 2.0
var delay_time = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ensure that frame2 starts invisible
	frame2.modulate.a = 0
	frame3.modulate.a = 0
	frame4.modulate.a = 0
	
	
	# Wait 5 seconds before starting the transition
	await get_tree().create_timer(delay_time).timeout
	_start_image_transition(frame1, frame2)
	await get_tree().create_timer(delay_time).timeout
	_start_image_transition(frame2, frame3)
	await get_tree().create_timer(delay_time).timeout
	_start_image_transition(frame3, frame4)
	await get_tree().create_timer(delay_time).timeout
	_start_image_transition(frame4, null)
	
	# Change the current scene to a new scene
	get_tree().change_scene_to_file("res://main_window.tscn")

	
# Starts the image transition animation
func _start_image_transition(first_sprite, second_sprite):
	# If there's an existing tween, stop it
	if tween:
		tween.kill()  # stop all active tweens, not kill them (better practice)
	
	# Create a new tween for the transition
	tween = get_tree().create_tween()

	# Set the easing type and transition for smooth animation
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	
	# Fade out frame1 (decrease opacity to 0)
	tween.tween_property(first_sprite, "modulate:a", 0, transition_duration)
	
	# Fade in frame2 (increase opacity to 1)
	tween.tween_property(second_sprite, "modulate:a", 1, transition_duration)
