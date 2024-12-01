extends Node2D

@export var enemy_scene: PackedScene
@export var enemy_scene2: PackedScene
@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn(stacja, amount):
	
	for i in range(amount):
		var enemy;
		if randi()%2==0:
			enemy = enemy_scene.instantiate()
		else:
			enemy = enemy_scene2.instantiate()
		if enemy:
			enemy.player = player
			enemy.SPEED = 500.0
			##enemy set skin
		
			get_parent().get_parent().add_child(enemy)
			enemy.global_position = self.global_position
		await get_tree().create_timer(0.8).timeout
	
	
