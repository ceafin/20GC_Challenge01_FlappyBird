extends Node2D

signal get_points

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_points_body_entered(body):
	emit_signal("get_points")
