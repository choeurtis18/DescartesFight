extends Area2D

var dead = false

func _ready():
	pass

func _process(delta):
	if dead == false:
		$AnimatedSprite.play("Idle")


func _on_Area2D_area_entered(area):
	if area.is_in_group("attak"):
		dead = true
		$AnimatedSprite.play(("dead"))


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "dead":
		queue_free()
