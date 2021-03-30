extends Control

var health = 100
onready var health_bar = get_node("Hp")

func _ready():	
	health_bar.max_value = health
	health_bar.value = health

func _process(delta):
	pass
	

