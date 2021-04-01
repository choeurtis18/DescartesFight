extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Music1 = load("res://graphics/sounds/Happy.wav")
var Music2 = load("res://graphics/sounds/guiles-theme-remix-super-smash-bros-ultimate.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func play_music():
	
	$Music.stream = Music1
	$Music.play()
	
func stop_music():
	$Music.stop()
	
func play_music2():
	$Music.stream = Music2
	$Music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
