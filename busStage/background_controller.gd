extends Node2D

@onready var Background1 = $Background
@onready var Background2 = $Background2
@onready var Background3 = $Background3

var scrollspeed = 3.1
var scrollItems = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scrollItems.append(Background1)
	scrollItems.append(Background2)
	scrollItems.append(Background3)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	for item in scrollItems:
		item.position.x -= scrollspeed
	

	if Background1.position.x < -2200:
		Background1.position.x = 2475
	if Background2.position.x < -2200:
		Background2.position.x = 2475
	if Background3.position.x < -2200:
		Background3.position.x = 2475	


func przyjazd():
	scrollspeed = 2.5
	await get_tree().create_timer(0.5).timeout
	scrollspeed = 2
	await get_tree().create_timer(0.5).timeout
	scrollspeed = 1.5
	await get_tree().create_timer(0.5).timeout
	scrollspeed = 1
	await get_tree().create_timer(0.5).timeout
	scrollspeed = 0.5
	await get_tree().create_timer(1).timeout
	scrollspeed = 0

func odjazd():
	scrollspeed = 0.5
	await get_tree().create_timer(0.5).timeout
	scrollspeed = 1
	await get_tree().create_timer(0.5).timeout
	scrollspeed = 1.5
	await get_tree().create_timer(0.5).timeout
	scrollspeed = 2
	await get_tree().create_timer(0.5).timeout
	scrollspeed = 2.5
	await get_tree().create_timer(1).timeout
	scrollspeed = 3
