extends Node


var nom_joueur = "bakari"
var index_joueur = 0

onready var anim_player = get_node("AnimationPlayer")
onready var label_name = get_node("label_name")
onready var label_player = get_node("label_player")
onready var sprite = get_node("Sprite")


func _ready():
	pass


func _process(delta):
	pass

func set_player(name):
	label_name.text = name
	anim_player.play(name)

func set_player_select(name):
	label_name.text = name
	anim_player.play(name+"_select")
	
func set_player_label():
	label_player.text = "Player 2"
	
	
