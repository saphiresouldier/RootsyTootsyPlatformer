class_name Bullet
extends RigidBody2D

onready var animation_player = $AnimationPlayer

var start_pos = Vector2(0, 0)

func destroy():
	animation_player.play("destroy")
	hide()
	var gun = get_node("/root/Game/Level/Player/Sprite/Gun")
	gun.set_active(false)

func _on_body_entered(body):
	if body is Enemy:
		body.destroy()

#func _process(delta):
#	var distance = position - start_pos
#	print(distance.length())
#
#func _init():
#	start_pos = position
