extends Sprite2D

func interact():
	
	DialogueManager.show_dialogue_balloon(load("res://dialog/lombard.dialogue"), "intro" + str(randi_range(1,3)))
	
	
