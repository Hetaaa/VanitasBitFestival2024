extends Node2D

@onready var timer = $Timer
@onready var backgroundController = $BackgroundController
@onready var enemySpawner = $EnemySpawner
@onready var enemySpawner2 = $EnemySpawner2
@onready var bus = $Bus

var canChangeScene = 0
var busStop: int = 1

var state: int = 0
# 0 - Odjazd
# 1 - Jazda
# 2 - Przyjazd
# 3 - Stop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if state == 3 and Input.is_action_pressed("spacja") and canChangeScene == 1:
		match busStop:
			1:
				get_tree().change_scene_to_file("res://sklep/komis/komis.tscn")
			3:
				get_tree().change_scene_to_file("res://sklep/zabka/zabka.tscn")
			5:
				get_tree().change_scene_to_file("res://sklep/bar/bar.tscn")
			7:		
				get_tree().change_scene_to_file("res://sklep/lombard/lombard.tscn")
	
func incrementStop():
	busStop = busStop + 1
	if busStop > 7:
		busStop = 1

func _on_timer_timeout() -> void:
	match state:
		0:
			state = 1
			timer.wait_time = 3
			timer.start()
			print("Busstate: Jazda")
			incrementStop()
		1:
			state = 2
			timer.wait_time = 3
			timer.start()
			backgroundController.przyjazd()
			print("Busstate: Przyjazd")
		2:
			state = 3
			timer.wait_time = 3
			timer.start()
			print("Busstate: Stop")
			
			enemySpawner.spawn(busStop, 3)
			enemySpawner2.spawn(busStop, 3)
		3:
			state = 0
			timer.wait_time = 3
			timer.start()
			backgroundController.odjazd()
			bus.setBusStop(busStop)
			print("Busstate: Odjazd")


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		canChangeScene = 1


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		canChangeScene = 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canChangeScene = 0


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canChangeScene = 0
