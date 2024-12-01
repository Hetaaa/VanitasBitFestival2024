extends Node2D


@onready var current_world = $World

func change_world(new: PackedScene):
	var old = current_world;
	var new_ins = new.instantiate()
	old.queue_free()
	add_child(new_ins)
	
