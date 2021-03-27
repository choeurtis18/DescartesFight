extends KinematicBody2D

var vel = Vector2()
var GRAVITY = 1000
export (int) var max_speed = 100
const UP = Vector2(0, -1)
const  ACCEL = 10

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
	
	if -25<x and x<25:
		$AnimationAI.play("attack")
	elif position.x > player.position.x :
		position += motion
		$Sprite.flip_h = true
		$AnimationAI.play("walk")
		
	elif position.x < player.position.x :
		position += motion
		$Sprite.flip_h = false
		$AnimationAI.play("walk")

	
