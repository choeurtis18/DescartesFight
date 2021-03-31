extends ColorRect

func _ready():
		pass
		
func _on_Timer_timeout():
	#cacher victory
	get_parent().get_node("Victory").visible = false
	#afficher end victory
	self.visible = true
	get_tree().paused = false
