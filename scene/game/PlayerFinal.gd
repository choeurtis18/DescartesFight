extends KinematicBody2D

var life:int = 100
var dead = false
var isHit = false

var vel = Vector2()
var GRAVITY = 1000
var isAttaking = false
export (int) var max_speed = 300
const UP = Vector2(0, -1)
const  ACCEL = 10


func setSprite(nom):
	var image = load(nom)
	$Sprite.set_texture(image)
	
func _physics_process(delta):
	vel.y += GRAVITY * delta
	if dead == false:
		movement_loop()
	vel = move_and_slide(vel, UP*delta)
	
func movement_loop():
	var left = Input.is_action_pressed("ui_q")
	var right = Input.is_action_pressed("ui_d")
	var jump = Input.is_action_pressed("ui_z")
	var sneak = Input.is_action_pressed("ui_s")
	var punch = Input.is_action_just_pressed("ui_a")
	var punch2 = Input.is_action_just_pressed("ui_e")
	var sp = Input.is_action_just_pressed("ui_r")
	
	var dirx = int(right) - int(left) #mouv gauche si -1 droite si 1
	
	#mouvements de base
	if isHit == true:
		$AnimationPlayer.play("hit")
		print(life)
	elif life <= 0 && $AnimationPlayer.current_animation != "dead":
		dead = true
		$AnimationPlayer.play("dead")
	elif sneak == true && dirx == 0 :
		$AnimationPlayer.play("sneak")
	elif is_on_floor() == false:
		$AnimationPlayer.play("jump")
	elif dirx != 0 && isAttaking == false:
		$AnimationPlayer.play("walk")
	elif punch == true && is_on_floor():
		isAttaking = true
		$AnimationPlayer.play("punch")
		Global.typeAttackJ1 = "punch" #type d'ataque pour le comtrole des degats
		filpAttaksArea($Sprite.flip_h)
	elif punch2 == true && is_on_floor():
		isAttaking = true
		$AnimationPlayer.play("punch2")
		Global.typeAttackJ1 = "punch2" #type d'ataque pour le comtrole des degats
		filpAttaksArea($Sprite.flip_h)
	elif sp == true && get_parent().get_node("SpControlJ1").get_node("Sp").value >= 100 && is_on_floor():
		isAttaking = true
		$AnimationPlayer.play("attacksp")
		Global.typeAttackJ1 = "attacksp" #type d'ataque pour le comtrole des degats
		get_parent().get_node("SpControlJ1").get_node("Sp").value = 0 #restar la jauge de coup spécial
		filpAttaksArea($Sprite.flip_h)
	else :
		if isAttaking == false && isHit == false:
			$AnimationPlayer.play("idle")

	if dirx == -1 :
		vel.x = max(vel.x - ACCEL, -max_speed)
		$Sprite.flip_h = true #inverse les sprites
	elif dirx == 1 :
		vel.x = min(vel.x + ACCEL, +max_speed)
		$Sprite.flip_h = false
	else:
		vel.x = lerp(vel.x, 0,0.15)
	
	if jump == true and is_on_floor():
		vel.y = -700


func _on_Body_area_entered(area):
	if area.get_name() == "AttackArea":
		isHit = true
		var spControl = get_parent().get_node("SpControlJ2").get_node("Sp")
		var hpControl = get_parent().get_node("HpControlJ1").get_node("Hp")
		
		print(Global.typeAttackJ2)
		if Global.typeAttackJ2 == "punch" or Global.typeAttackIA == "punch":
			life = life - 10
			hpControl.value -=10
			spControl.value += 15
		elif Global.typeAttackJ2 == "punch2" or Global.typeAttackIA == "punch2":
			life = life - 15
			hpControl.value -=15
			spControl.value += 20
		else: 
			life = life - 25
			hpControl.value -=25

func _on_AnimationPlayer_animation_finished(anim_name):
	#desactiver les hitbox si l'annimation de coup se termine
	if anim_name == "punch" or anim_name == "punch2" or anim_name == "attacksp":
		$AttackArea/CollisionShape2D1.disabled = true
		$AttackArea/CollisionShape2D2.disabled = true
		isAttaking = false
	#desactive l'animation hit
	elif anim_name == "hit":
		isHit = false

func filpAttaksArea(position):
	#selectionner la bonne hitbox en fonction de la position du perso
	if position == true :
		$AttackArea/CollisionShape2D2.disabled = false
	elif position == false :
		$AttackArea/CollisionShape2D1.disabled = false

