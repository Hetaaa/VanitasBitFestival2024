extends Sprite2D
var canChangeScene = 0
@onready var area = $przystanekarea

@onready var space1 = $space1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canChangeScene == 1:
		space1.show()
	else:
		space1.hide()
	if Input.is_action_pressed("spacja") and canChangeScene == 1:
		get_tree().change_scene_to_file("res://main_window.tscn")




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		canChangeScene = 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canChangeScene = 0
