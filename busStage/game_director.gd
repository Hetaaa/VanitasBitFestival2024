extends Node2D

@onready var timer = $Timer
@onready var backgroundController = $BackgroundController
@onready var enemySpawner = $EnemySpawner
@onready var bus = $Bus


var busStop: int = 1

var state: int = 0
# 0 - Odjazd
# 1 - Jazda
# 2 - Przyjazd
# 3 - Stop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
			timer.wait_time = 1
			timer.start()
			print("Busstate: Stop")
			
			enemySpawner.spawn(busStop)
		3:
			state = 0
			timer.wait_time = 3
			timer.start()
			backgroundController.odjazd()
			bus.setBusStop(busStop)
			print("Busstate: Odjazd")
