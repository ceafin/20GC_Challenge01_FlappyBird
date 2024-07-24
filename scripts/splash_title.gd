extends Node2D

const LEVEL = preload("res://scenes/level.tscn")



func _unhandled_input(event):
	if Input.is_action_just_released("ui_accept"):
		get_tree().change_scene_to_packed(LEVEL)
