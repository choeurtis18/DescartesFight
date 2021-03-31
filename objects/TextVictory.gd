extends Label

func go():
	if Global.stateGame == "vP1": 
		self.text = "PLAYER 1 WINS"
	elif Global.stateGame == "vP2": 
		self.text = "PLAYER 2 WINS"
	elif Global.stateGame == "vIA": 
		self.text = "IA WINS"
