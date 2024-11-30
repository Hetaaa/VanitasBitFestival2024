extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State = null
var states: Dictionary = {}

func _ready():
	# Dodajemy wszystkie stany jako dzieci maszyny stanów
	for child in get_children():
		if child is State:
			states[child.name] = child
	# Przechodzimy do początkowego stanus
	change_state(initial_state.name)

func change_state(new_state: String):
	if current_state:
		current_state.Exit()
	if new_state in states:
		current_state = states[new_state]
		current_state.Enter()
		current_state.connect("Transitioned",Callable(self, "_on_state_transitioned"))
	else:
		print("State not found: ", new_state)

func _on_state_transitioned(new_state: String):
	change_state(new_state)

func _process(delta: float):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float):
	if current_state:
		current_state.PhysicsUpdate(delta)
func _get_state_name() -> String:
	return current_state.name
