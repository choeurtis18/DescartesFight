extends Node2D

onready var playerJ1 = get_node("Player")
onready var playerJ2 = get_node("AI")

var pathP1 = getPlayer(Global.player1)
var pathP2 = getPlayer(Global.player2)
	
func _ready():
	playerJ1.setSprite(pathP1)
	playerJ2.setSprite(pathP2)
	#var image_map = "res://graphics/Terrain/"+Global.map
	#$Area2D/Sprite.set_texture(load(image_map))


func init():
	pass

func getPlayer(player_name):
	print(player_name)
	if player_name == "samy":
		return "res://graphics/Sprite/SAMY.png"
	elif player_name == "bakari":
		return "res://graphics/Sprite/BAKARI.png"
	elif player_name == "victor":
		return "res://graphics/Sprite/VICTOR.png"
	elif player_name == "yannis":
		return "res://graphics/Sprite/YANNIS.png"
	elif player_name == "justine":
		return "res://graphics/Sprite/JUSTINE.png"
	
