extends Node2D

var max_player = 7
var player1_id = 1
var player2_id = 1
var player1_select = false
var player2_select = true
var Sound = load("res://graphics/sounds/vc_menu_narration_choosechara.wav")

onready var backGround = get_node("backGround")
onready var msg = get_node("msg")
onready var portraits = get_node("portraits")
onready var button = get_node("Button")
onready var player_view1 = get_node("preview_player1")
onready var player_view2 = get_node("preview_player2")


func _ready():
	if !$Sound2.is_playing():
			$Sound2.stream = Sound
			$Sound2.play()	
	for face in portraits.get_children():
		if face.name == "bakari" :
			face.set_player("bakari")
		elif face.name == "yannis" :
			face.set_player("yannis")
		elif face.name == "victor" :
			face.set_player("victor")
		elif face.name == "samy" :
			face.set_player("samy")
		elif face.name == "farah" :
			face.set_player("farah")
		elif face.name == "justine" :
			face.set_player("justine")
		elif face.name == "choeurtis" :
			face.set_player("choeurtis")
	player_view2.set_player_label()
	player_view2.label_player.add_color_override("font_color", Color(0, 0, 1))

func _process(delta):
		if not player1_select:
			if Input.is_action_just_pressed("ui_q"):
				player1_id -= 1
			if Input.is_action_just_pressed("ui_d"):
				player1_id += 1
			if player1_id < 1:
				player1_id = max_player
			elif player1_id > max_player:
				player1_id = 1
			shine_portrait(player1_id)
			
			var name = getNamePlayer(player1_id)
			player_view1.set_player(name)
			
			if Input.is_action_just_pressed("ui_accept"):
				player_view1.set_player_select(name)
				Global.player1 = name
				player1_select = true
				player2_select = false
				
		elif not player2_select:
			if Input.is_action_just_pressed("ui_q"):
				player2_id -= 1
			if Input.is_action_just_pressed("ui_d"):
				player2_id += 1
			if player2_id < 1:
				player2_id = max_player
			elif player2_id > max_player:
				player2_id = 1
			shine_portrait(player2_id)
			
			
			var name = getNamePlayer(player2_id)
			player_view2.set_player(name)
			
			if Input.is_action_just_pressed("ui_accept") and Global.player1 != name:
				player_view2.set_player_select(name)
				player2_select = true
				Global.player2 = name
		
		if player1_select==true and player2_select==true:
			get_tree().change_scene("res://scene/menuMaps/selectMap.tscn")
	
func getNamePlayer(id):
	if id == 1:
		return "bakari"
	if id == 2:
		return "yannis"
	if id == 3:
		return "victor"
	if id == 4:
		return "samy"
	if id == 5:
		return "farah"
	if id == 6:
		return "justine"
	if id == 7:
		return "choeurtis"

func getIdPlayer(name):
	if name == "bakari":
		return 1
	if name == "yannis":
		return 2
	if name == "victor":
		return 3
	if name == "samy":
		return 4
	if name == "farah":
		return 5
	if name == "justine":
		return 6
	if name == "choeurtis":
		return 7

func shine_portrait(id):
	for face in portraits.get_children():
		if face.name == getNamePlayer(id):
			face.frame = 1
		else:
			face.frame = 0
