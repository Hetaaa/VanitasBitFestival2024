extends CanvasLayer
@onready var health_ui = $Screen/VBoxContainer/HBoxContainer/TextureRect/ProgressBar

@onready var money_ui = $Screen/VBoxContainer/HBoxContainer/TextureRect2/Label


func _on_player_change_health(health) -> void:
	health_ui.value = health


func _on_player_change_kasa(kasa) -> void:
	money_ui.text = str(kasa) + "złs"
