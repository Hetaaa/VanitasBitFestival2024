extends Sprite2D

@onready var Label1 = $Label
@onready var Label2 = $Label2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setBusStop(stopNumber):
	await get_tree().create_timer(1).timeout
	var labeltext = "Nast. Przystanek"
	Label1.text = labeltext
	Label2.text = labeltext
	await get_tree().create_timer(2).timeout
	
	match stopNumber:
		1: 
			labeltext = "ul. Handlowa"
		2:
			labeltext = "ul. Biznesowa"
		3:
			labeltext = "ul. Sklepowa"
		4:
			labeltext = "ul. Osiedlowa"
		5:
			labeltext = "ul. Baorwa"
		6:
			labeltext = "ul. Stadionowa"
		7:
			labeltext = "ul. Lombardowa"
	Label1.text = labeltext
	Label2.text = labeltext
