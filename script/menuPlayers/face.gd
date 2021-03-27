extends Sprite

var nom_joueur = "bakari"
var select_timer = -1
var max_select_timer = 60

onready var anim_player = get_node("AnimationPlayer")
onready var nom = get_node("nom")
onready var sprite = get_node("Sprite")


func _ready():
	nom.text = nom_joueur
	anim_player.play(nom_joueur)


func _process(delta):
	if select_timer > 0:
		select_timer -= 1
		var temp = select_timer / 3
		if temp % 2 == 0:
			frame = 1
		else:
			frame = 0

func set_player(name):
	nom.text = name
	anim_player.play(name)
	
func return_player_name():
	return nom_joueur
