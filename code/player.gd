extends KinematicBody2D

#Constante
const GRAVITY = 1000
const UP = Vector2(0, -1)
const ACELLECATION = 10

#Variable
var vel = Vector2() #velocite
var max_speed = 250 #vitesse
var saut = 700 

func _ready():
	pass

func _process(delta):#execute l'action selon les fps
	pass

func _physics_process(delta):#execute l'action 60 fois/sec
	mouvement_loop()
	#delta = temps ecoule depuis la derniere frame
	vel.y += GRAVITY*delta
	
	
	vel = move_and_slide(vel, UP) #UP = plafond

func mouvement_loop() :
	var droite = Input.is_action_pressed("ui_droite")
	var gauche = Input.is_action_pressed("ui_gauche")
	var dirx = int(droite) - int(gauche) #direction sur axe x
	var haut = Input.is_action_just_pressed("ui_haut")
	
	if dirx == -1:
		#vel.x -= max_speed
		vel.x = max(vel.x-ACELLECATION, -max_speed)
		$Sprite.flip_h = true
		animation_loop("Walk")
	elif dirx == 1:
		#vel.x += speed
		vel.x = min(vel.x+ACELLECATION, max_speed)
		$Sprite.flip_h = false
		animation_loop("Walk")
	else :
		vel.x = lerp(vel.x, 0, 0.30) #Stop l'animation progressivement si aucune touche n'est presse
		animation_loop("Waiting")
	
	if haut == true and is_on_floor():
		vel.y = -saut
		
	if vel.y < 0 :
		animation_loop("Jump")
	if vel.y > 0 :
		animation_loop("Down")

func animation_loop(animation):
	if $AnimationPlayer.current_animation != animation :
		$AnimationPlayer.play(animation)

