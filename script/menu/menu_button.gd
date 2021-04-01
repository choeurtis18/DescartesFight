extends Button

export var reference_path = ""
export(bool) var start_focused = false
var Sound = load("res://graphics/Sounds/se_menu_edgechallenge_pressstart.wav")

func _ready():
	if(start_focused):
		grab_focus()
		
	connect("mouse_entered",self,"_on_Button_mouse_entered")
	connect("pressed",self,"_on_Button_Pressed")

func _on_Button_mouse_entered():
	grab_focus()
	
func _on_Button_Pressed():
	if(reference_path != ""):
		
		if !$Sound1.is_playing():
			$Sound1.stream = Sound
			$Sound1.play()
		get_tree().change_scene(reference_path)		
	
	else:
		get_tree().quit()
