extends Node
var player : CharacterBody2D;
var money = 100

func take_money():
	money -=5
func get_money():
	return money

func give_player(ask, what):
	if money >= ask:
		player.get_thing(what)
		
func buy_car():
	print("you bought car")
