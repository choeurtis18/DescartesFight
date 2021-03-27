extends Node

var map_select = false
var map_name = "map1"
var map_id = 1
var max_map = 8

onready var backGround = get_node("backGround")
onready var msg = get_node("msg")
onready var maps = get_node("maps")

func _ready():
	for map in maps.get_children():
		if map.name == "amphi_1" :
			map.set_map("amphi_1")
		elif map.name == "amphi_2" :
			map.set_map("amphi_2")
		elif map.name == "amphi_3" :
			map.set_map("amphi_3")
		elif map.name == "cafet" :
			map.set_map("cafet")
		elif map.name == "couloir_1" :
			map.set_map("couloir_1")
		elif map.name == "couloir_amphi" :
			map.set_map("couloir_amphi")
		elif map.name == "exterieur_1" :
			map.set_map("exterieur_1")
		elif map.name == "exterieur_2" :
			map.set_map("exterieur_2")


func _process(delta):
	if not map_select:
		if Input.is_action_just_pressed("ui_q"):
			map_id -= 1
		if Input.is_action_just_pressed("ui_d"):
			map_id += 1
		if map_id < 1:
			map_id = max_map
		elif map_id > max_map:
			map_id = 1
		shine_map(map_id)
		
		var name = getNameMap(map_id)
		
		if Input.is_action_just_pressed("ui_accept"):
			Global.map = name
			map_select = true
			
			print(Global.typeGame)
			
			if Global.typeGame == "MODE 1 VS IA":
				get_tree().change_scene("res://ModeAI/AI.tscn")
			elif Global.typeGame == "MODE 1 VS 1":
				get_tree().change_scene("res://ModeMulti/Multi.tscn")
	
func getNameMap(id):
	if id == 1:
		return "amphi_1"
	if id == 2:
		return "amphi_2"
	if id == 3:
		return "amphi_3"
	if id == 4:
		return "cafet"
	if id == 5:
		return "couloir_1"
	if id == 6:
		return "couloir_amphi"
	if id == 7:
		return "exterieur_1"
	if id == 8:
		return "exterieur_2"

func shine_map(id):
	for map in maps.get_children():
		if map.name == getNameMap(id):
			map.frame = 1
		else:
			map.frame = 0
