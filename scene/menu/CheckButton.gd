extends CheckButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CheckButton_pressed():

	if Global.EtatMusic == true:
		MusicController.stop_music();
		Global.EtatMusic = false;
	else:
		MusicController.play_music()
		Global.EtatMusic = true;
	pass # Replace with function body.
