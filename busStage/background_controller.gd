extends Node2D

@onready var Background1 = $Background
@onready var Background2 = $Background2
@onready var Background3 = $Background3

@onready var Bar = $Bar
@onready var Zakba = $Zabka
@onready var Auto = $Auto
@onready var Lombard = $Lombard	

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
	
	if Bar.position.x < -2200:
		Bar.position.x = 2475	
		scrollItems.erase(Bar)
	if Zakba.position.x < -2200:
		Zakba.position.x = 2475	
		scrollItems.erase(Zakba)
	if Auto.position.x < -2200:
		Auto.position.x = 2475	
		scrollItems.erase(Auto)
	if Lombard.position.x < -2200:
		Lombard.position.x = 2475	
		scrollItems.erase(Lombard)


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

func spawnObj(no):
	match no:
		7:
			qAuto()
		2:
			qZakba()
		4: 
			qBar()
		5: 
			qLombard()
func qZakba():
	scrollItems.append(Zakba)
func qBar():
	scrollItems.append(Bar)
func qAuto():
	scrollItems.append(Auto)
func qLombard():
	scrollItems.append(Lombard)
