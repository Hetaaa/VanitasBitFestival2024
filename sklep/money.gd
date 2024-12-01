extends Node
var player : CharacterBody2D;

func get_money():
	return Global.kasa

func give_player(ask, what):
	if Global.kasa >= ask:
		player.get_thing(what)
		
		
func buy_car():
	print("you bought car")
