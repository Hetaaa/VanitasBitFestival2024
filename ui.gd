extends CanvasLayer
@onready var health_ui = $Screen/VBoxContainer/HBoxContainer/TextureRect/ProgressBar

@onready var money_ui = $Screen/VBoxContainer/HBoxContainer/TextureRect2/Label

@onready var game_over = $Screen/Die


func _process(delta: float) -> void:
	health_ui.value = Global.health
	money_ui.text = str(Global.kasa) + "zł"

func _on_player_player_dead() -> void:
	game_over.show()
