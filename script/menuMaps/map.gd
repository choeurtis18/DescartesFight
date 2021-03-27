extends Sprite

onready var anim_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_map(name):
	anim_player.play(name)
