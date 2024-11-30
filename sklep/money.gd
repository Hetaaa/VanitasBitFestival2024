extends Node
var player : CharacterBody2D;
var money = 100

func take_money():
	money -=5
func get_money():
	return money

func give_player():
	player.get_thing()
