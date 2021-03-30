extends KinematicBody2D

var vel = Vector2()
var GRAVITY = 1000
export (int) var max_speed = 250
const UP = Vector2(0, -1)
const  ACCEL = 50

func _ready():
	pass
	
func setSprite(nom):
	var image = load(nom)
	$Sprite.set_texture(image)
	
func _physics_process(delta):
	
	vel.y += GRAVITY * delta
	movement_loop(delta)
	vel = move_and_slide(vel,UP)
	
func movement_loop(delta):
	var player=get_parent().get_node("Player")
	var dirx=(player.position - position).normalized()
	var motion = dirx * max_speed * delta
	
	var x = player.position.x - position.x
	
	
	if -120<x and x<120:
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
		$AnimationAI.play("walk")


func attack():    
	var t = RandomNumberGenerator.new()
	t.randomize()
	var n = t.randi_range ( 1, 2 )
	print(n)
	if n == 1:
		$AnimationAI.play("punch")
	elif n == 2:
		$AnimationAI.play("punch2")

