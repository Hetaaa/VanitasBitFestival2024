extends Sprite2D

func interact():
	DialogueManager.show_dialogue_balloon(load("res://dialog/sklep.dialogue"), "intro" + str(randi_range(1,3)))
	
