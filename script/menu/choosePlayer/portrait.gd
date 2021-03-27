extends Sprite

export var character = "goto"
export var option_num = 1

var select_timer = -1
var max_select_timer = 60

onready var anim_player = get_node("AnimationPlayer")
onready var label_player1 = get_node("label_player1")
onready var label_player2 = get_node("label_player2")

func _ready():
	label_player1.visible = false
	label_player2.visible = false
	anim_player.play(character)

func _process(delta):
	if select_timer > 0:
		select_timer -= 1
		var temp = select_timer / 3
		if temp % 2 == 0:
			frame = 1
		else:
			frame = 0

func set_highlight(player1_num, player2_num):
	if option_num == player1_num or option_num == player2_num:
		frame = 1
	else:
		frame = 0
	label_player1.visible = (option_num == player1_num)
	label_player2.visible = (option_num == player2_num)

func player_selected(player_num):
	return option_num == player_num

func select(player_num):
	if option_num == player_num:
		select_timer = max_select_timer
