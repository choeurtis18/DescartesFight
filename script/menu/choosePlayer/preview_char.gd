extends Node2D

export var player_num = 1

var anim = "goto"
var selected = false

onready var anim_player = get_node("AnimationPlayer")
onready var char_spr = get_node("char")
onready var label_name = get_node("label_name")
onready var label_player = get_node("label_player")

func _ready():
	if player_num == 2:
		label_player.text = "Player 2"
		label_player.add_color_override("font_color", Color(0, 0, 1))
		char_spr.scale.x = -1
	label_name.text = "Shoto Goto"
	anim_player.play(anim)

func change_char(char_name):
	if not selected:
		match char_name:
			"goto":
				label_name.text = "Shoto Goto"
			"darkgoto":
				label_name.text = "Dark Goto"
		if anim != char_name:
			anim = char_name
			anim_player.play(anim)

func select():
	anim_player.play(anim + "_select")
	selected = true
