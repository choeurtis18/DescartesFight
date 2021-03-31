extends Node2D

onready var playerJ1 = get_node("Player1")
onready var playerJ2 = get_node("Player2")


var pathP1 = getPlayer(Global.player1)
var pathP2 = getPlayer(Global.player2)
var pathMap = getMap(Global.map)

func _ready():
	playerJ1.setSprite(pathP1)
	playerJ2.setSprite(pathP2)
	
	var image = load(pathMap)
	$Area2D/Sprite.set_texture(image)

func init():
	pass

func getPlayer(player_name):
	if player_name == "samy":
		return "res://graphics/Sprite/SamyFinal.png"
	elif player_name == "bakari":
		return "res://graphics/Sprite/BakariFinal.png"
	elif player_name == "victor":
		return "res://graphics/Sprite/Victorfinal.png"
	elif player_name == "yannis":
		return "res://graphics/Sprite/Yannisfinal.png"
	elif player_name == "justine":
		return "res://graphics/Sprite/Justinefinal.png"
	elif player_name == "farah":
		return "res://graphics/Sprite/Farahfinal.png"
	elif player_name == "choeurtis":
		return "res://graphics/Sprite/Choeurtisfinal.png"

func getMap(map_name):
	if map_name == "map1":
		return "res://graphics/maps/map1.jpg"
	elif map_name == "map2":
		return "res://graphics/maps/map2.jpg"
	elif map_name == "map3":
		return "res://graphics/maps/map3.jpg"
	elif map_name == "map4":
		return "res://graphics/maps/map4.jpg"
	elif map_name == "map5":
		return "res://graphics/maps/map5.jpg"
	elif map_name == "map6":
		return "res://graphics/maps/map6.jpg"
