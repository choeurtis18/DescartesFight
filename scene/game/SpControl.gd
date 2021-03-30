extends Control

var sp = 0
onready var sp_bar = get_node("Sp")

func _ready():	
	sp_bar.max_value = 100
	sp_bar.value = sp

func _process(delta):
	pass
	
