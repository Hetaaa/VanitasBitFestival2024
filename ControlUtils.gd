extends Control

# Usuwa wszystkie dzieci węzła
func clear_children():
	for child in get_children():
		child.queue_free()
