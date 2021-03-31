extends Control

func go():
	self.visible = true
	get_node("Victory").visible = true
	get_node("Victory/TextVictory").go()
	get_node("Victory/TextVictory").visible = true
	get_node("Timer").start()
	


