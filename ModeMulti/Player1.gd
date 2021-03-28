extends KinematicBody2D

var vel = Vector2()
var GRAVITY = 1000
var isAttaking = false
export (int) var max_speed = 300
const UP = Vector2(0, -1)
const  ACCEL = 10


func setSprite(nom):
	var image = load(nom)
	$SpriteJ1.set_texture(image)
	
func _physics_process(delta):
	vel.y += GRAVITY * delta
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
	
	var dirx = int(right) - int(left)

	if sneak == true:
		$AnimationPlayer.play("sneak")
	elif is_on_floor() == false:
		$AnimationPlayer.play("jump")
	elif dirx != 0 && isAttaking == false:
		$AnimationPlayer.play("walk")
	elif punch == true:
		isAttaking = true
		$AnimationPlayer.play("punch")
		filpAttaksArea($Sprite.flip_h)
	elif punch2 == true:
		isAttaking = true
		$AnimationPlayer.play("punch2")
		filpAttaksArea($Sprite.flip_h)
	elif sp == true:
		isAttaking = true
		$AnimationPlayer.play("attacksp")
		filpAttaksArea($Sprite.flip_h)
	else :
		if isAttaking == false:
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

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "punch" or anim_name == "punch2" or anim_name == "attacksp":
		$AttackArea/CollisionShape2D1.disabled = true
		$AttackArea/CollisionShape2D2.disabled = true
		isAttaking = false

func filpAttaksArea(position):
	if position == true :
		$AttackArea/CollisionShape2D2.disabled = false
	elif position == false :
		$AttackArea/CollisionShape2D1.disabled = false

