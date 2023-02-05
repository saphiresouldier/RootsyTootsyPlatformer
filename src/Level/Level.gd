extends Node2D


const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 1500
const LIMIT_BOTTOM = 690


func _ready():
	for child in get_children():
		if child is Player:
			var camera = child.get_node("Camera")
			camera.limit_left = LIMIT_LEFT
			camera.limit_top = LIMIT_TOP
			camera.limit_right = LIMIT_RIGHT
			camera.limit_bottom = LIMIT_BOTTOM



func _on_Area2D_body_entered(body, extra_arg_0):
	print("Load level: ")
	print(extra_arg_0)
	if extra_arg_0 == 1:
		get_tree().change_scene("res://src/Main/Game_2.tscn")
	elif extra_arg_0 == 0:
		get_tree().change_scene("res://src/Main/Game.tscn")
	elif extra_arg_0 == 2:
		get_tree().change_scene("res://src/Main/Game_3.tscn")
