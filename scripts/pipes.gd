extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_points_body_entered(body):
	print( "Something entered score area: ", str(body) )
	if body is Birb:
		EventBus.get_points.emit()


func _on_hit_a_pipe(body):
	print( "Something hit a pipe: ", str(body) )
	if body is Birb:
		EventBus.hit_pipe.emit()
