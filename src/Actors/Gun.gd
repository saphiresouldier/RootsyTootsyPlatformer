class_name Gun
extends Position2D
# Represents a weapon that spawns and shoots bullets.
# The Cooldown timer controls the cooldown duration between shots.

const BULLET_VELOCITY = 400.0
const Bullet = preload("res://src/Objects/Bullet.tscn")
export var root_distance = 200 # how far the root reaches
export var fill_elements = 20
onready var sound_shoot = $Shoot
onready var timer = $Cooldown

var active = false
var player = Player

var bullet_front = Bullet
var bullet_back = Bullet
var bullet_middle = []
var forward_direction = 1
var forward = true

func _ready():
	player = get_parent().get_parent()

# This method is only called by Player.gd.
func shoot(direction = 1):
	if not timer.is_stopped():
		return false
	bullet_front = Bullet.instance()
	bullet_front.global_position = global_position
	bullet_front.linear_velocity = Vector2(direction * BULLET_VELOCITY, 0)
	forward_direction = direction
	
	bullet_back = Bullet.instance()
	bullet_back.set_as_toplevel(true)
	add_child(bullet_back)
	
	bullet_front.set_as_toplevel(true)
	add_child(bullet_front)
	sound_shoot.play()
	timer.start()
	
	for i in fill_elements:
		bullet_middle.append(Bullet.instance())
		bullet_middle[i].set_as_toplevel(true)
		add_child(bullet_middle[i])
	
	active = true
	return true

func _process(delta):
	#print(player.position)
	if active:
		var distance = Vector2(bullet_front.global_position - player.position).length();
		print(distance)
		if (distance > root_distance) and forward:
			bullet_front.linear_velocity = Vector2(-forward_direction * BULLET_VELOCITY, 0)
			forward = false
		bullet_back.global_position = global_position
		for i in fill_elements:
			#print(float(i)/fill_elements
			bullet_middle[i].global_position = bullet_front.global_position.linear_interpolate(bullet_back.global_position, float(i)/fill_elements)

func set_active(new_active):
	active = new_active
	if new_active == false:
		forward_direction = 1
		forward = true
		bullet_middle.clear()
