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
		if map.name == "map1" :
			map.set_map("map1")
		elif map.name == "map2" :
			map.set_map("map2")
		elif map.name == "map3" :
			map.set_map("map3")
		elif map.name == "map4" :
			map.set_map("map4")
		elif map.name == "map5" :
			map.set_map("map5")
		elif map.name == "map6" :
			map.set_map("map6")


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
			
			if Global.EtatMusic == true:
				MusicController.stop_music()
				MusicController.play_music2()
			else:
				MusicController.stop_music()
			
			print(Global.typeGame)
			
			if Global.typeGame == "MODE 1 VS IA":
				get_tree().change_scene("res://ModeAI/IA.tscn")
			elif Global.typeGame == "MODE 1 VS 1":
				get_tree().change_scene("res://ModeMulti/Multi.tscn")
	
func getNameMap(id):
	if id == 1:
		return "map1"
	if id == 2:
		return "map2"
	if id == 3:
		return "map3"
	if id == 4:
		return "map4"
	if id == 5:
		return "map5"
	if id == 6:
		return "map6"

func shine_map(id):
	for map in maps.get_children():
		if map.name == getNameMap(id):
			map.frame = 1
		else:
			map.frame = 0
