extends Node2D

var state = "select"
var bg_move = 3
var max_bg_move = 15
var transition_alpha = 1
var change_alpha = 0.1
var player1_select = 1
var player2_select = 1
var player1_selected = false
var player2_selected = false
var max_select = 2
var move_timer = -1
var max_move_timer = 120

onready var audio = get_node("AudioStreamPlayer2D")
onready var label_select = get_node("label_select")
onready var bg = get_node("bg")
onready var transition = get_node("transition")
onready var portraits = get_node("portraits")
onready var preview_player1 = get_node("preview_player1")
onready var preview_player2 = get_node("preview_player2")

onready var snd_select = preload("res://sounds/select.wav")

func _ready():
	transition.visible = true

func _process(delta):
	transition.set_modulate(Color(1, 1, 1, transition_alpha))
	if state == "select":
		if transition_alpha > 0:
			transition_alpha -= change_alpha
		if bg_move > 3:
			bg_move -= 0.5
		
		if not player1_selected:
			if Input.is_action_just_pressed("player1_left"):
				player1_select -= 1
			if Input.is_action_just_pressed("player1_right"):
				player1_select += 1
			if player1_select < 1:
				player1_select = max_select
			elif player1_select > max_select:
				player1_select = 1
				
			if Input.is_action_just_pressed("player1_attack") or Input.is_action_just_pressed("player1_special"):
				for portrait in portraits.get_children():
					portrait.select(player1_select)
				preview_player1.select()
				player1_selected = true
				bg_move = max_bg_move
				play_audio(snd_select)
		
		if not player2_selected:
			if Input.is_action_just_pressed("player2_left"):
				player2_select -= 1
			if Input.is_action_just_pressed("player2_right"):
				player2_select += 1
			if player2_select < 1:
				player2_select = max_select
			elif player2_select > max_select:
				player2_select = 1
			
			if Input.is_action_just_pressed("player2_attack") or Input.is_action_just_pressed("player2_special"):
				for portrait in portraits.get_children():
					portrait.select(player2_select)
				preview_player2.select()
				player2_selected = true
				bg_move = max_bg_move
				play_audio(snd_select)
			
		for portrait in portraits.get_children():
			portrait.set_highlight(player1_select, player2_select)
			if portrait.player_selected(player1_select):
				preview_player1.change_char(portrait.character)
				global.player1_char = portrait.character
			if portrait.player_selected(player2_select):
				preview_player2.change_char(portrait.character)
				global.player2_char = portrait.character
		
		if player1_selected and player2_selected:
			move_timer = max_move_timer
			transition_alpha = 0
			state = "move"
	else:
		label_select.text = "GET READY TO FIGHT!"
		if move_timer > 0:
			move_timer -= 1
			if transition_alpha < 1 and move_timer < max_move_timer / 4:
				transition_alpha += change_alpha
		else:
			get_tree().change_scene("res://scenes/game.tscn")
	if bg_move > 0:
		bg.set_position(Vector2(bg.get_position().x, bg.get_position().y + bg_move))
		if bg.get_position().y > 300:
			bg.set_position(Vector2(get_position().x, -300))

func play_audio(snd):
	audio.stream = snd
	audio.play(0)
