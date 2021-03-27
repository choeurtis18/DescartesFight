extends Control


onready var options = get_node("VBoxContainer")


func _ready():
	pass

func _process(delta):
	for option in options.get_children():
		if option.pressed:
			Global.typeGame = option.text
