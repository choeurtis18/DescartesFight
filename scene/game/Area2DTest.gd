extends Area2D

var life:int = 100
var dead = false
var isHit = false

func _ready():
	pass

func _physics_process(delta):
	if dead == false:
		movement_loop()

func movement_loop():
		if isHit == true:
			$AnimatedSprite.play("Hit")
			print(life)
		elif life <= 0 && $AnimatedSprite.animation != "dead":
			dead = true
			$AnimatedSprite.play("dead")
		else:
			if isHit == false:
				$AnimatedSprite.play("Idle")

func _on_Area2D_area_entered(area):
	if area.is_in_group("attack"):
		isHit = true	
		if Global.typeAttack == "punch":
			life = life - 10
			get_parent().get_node("HpP2").get_node("Hp").value -=10
			get_parent().get_node("SpControlP1").get_node("Sp").value += 15
		elif Global.typeAttack == "punch2":
			life = life - 15
			get_parent().get_node("HpP2").get_node("Hp").value -=15
			get_parent().get_node("SpControlP1").get_node("Sp").value += 20
		else: 
			life = life - 25
			get_parent().get_node("HpP2").get_node("Hp").value -= 15

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Hit":
		isHit = false
