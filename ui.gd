extends CanvasLayer
@onready var health_ui = $Screen/VBoxContainer/HBoxContainer/TextureRect/ProgressBar

@onready var money_ui = $Screen/VBoxContainer/HBoxContainer/TextureRect2/Label

@onready var game_over = $Screen/Die

func _on_player_change_health(health) -> void:
	health_ui.value = health


func _on_player_change_kasa(kasa) -> void:
	money_ui.text = str(kasa) + "złs"


func _on_player_player_dead() -> void:
	game_over.show()
