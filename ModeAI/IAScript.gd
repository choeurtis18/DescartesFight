extends KinematicBody2D

var life:int = 100
var dead = false
var isHit = false

var vel = Vector2()
var GRAVITY = 1000
var isAttaking = false
export (int) var max_speed = 200
const UP = Vector2(0, -1)
const  ACCEL = 10


func setSprite(nom):
	var image = load(nom)
	$Sprite.set_texture(image)
	
func _physics_process(delta):
	vel.y += GRAVITY * delta
	if dead == false:
		movement_loop(delta)
	vel = move_and_slide(vel, UP*delta)
	
	
func movement_loop(delta):
	var player=get_parent().get_node("Player")
	var dirx=(player.position - position).normalized()
	var motion = dirx * max_speed * delta
	
	var x = player.position.x - position.x
	
	if isHit == true:
		if(yield($AnimationAI, "animation_finished")):
			$AnimationAI.play("hit")
	elif life <= 0 && $AnimationAI.current_animation != "dead":
		dead = true
		$AnimationAI.play("dead")
	elif -120<x and x<120 :
		if isAttaking == false:
			attack()
		vel.x = 0
	else: 
		if x < 0 :
			vel.x = max(vel.x - ACCEL, -max_speed)
			$Sprite.flip_h = true #inverse les sprites
		elif x > 0 :
			vel.x = min(vel.x + ACCEL, +max_speed)
			$Sprite.flip_h = false
		else:
			vel.x = lerp(vel.x, 0,0.15)
		if(yield($AnimationAI, "animation_finished")):
			$AnimationAI.play("walk")

	#if jump == true and is_on_floor():
	#	vel.y = -700


func attack():    
	var t = RandomNumberGenerator.new()
	t.randomize()
	var n = t.randi_range ( 1, 2 )
	isAttaking = true
	
	if n == 1:
		$AnimationAI.play("punch")
		Global.typeAttackIA = "punch"
		filpAttaksArea($Sprite.flip_h)
	elif n == 2:
		$AnimationAI.play("punch2")
		Global.typeAttackIA = "punch2"
		filpAttaksArea($Sprite.flip_h)

func _on_Body_area_entered(area):
	if area.get_name() == "AttackArea":
		isHit = true
		var spControl = get_parent().get_node("SpControlJ1").get_node("Sp")
		var hpControl = get_parent().get_node("HpControlJ2").get_node("Hp")
		
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

