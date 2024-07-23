extends Node2D

const PIPES = preload("res://scenes/pipes.tscn")

@onready var bg_scene_1 = $BGScene1
@onready var bg_scene_2 = $BGScene2
@onready var pipe_spawner = $PipeSpawner
@onready var bgs = $BGs
@onready var all_pipes = $All_Pipes

# Called when the node enters the scene tree for the first time.
func _ready():
	pipe_spawner.connect("timeout", _on_pipespawner_timeout)
	pipe_spawner.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for background in bgs.get_children():
		if background.position.x < -335:
			background.position.x = 320
		
		background.position.x += -1 * delta * 45
		
	for pipe in all_pipes.get_children():
		if pipe.position.x < -64:
			pipe.queue_free()
		
		pipe.position.x += -1 * delta * 75


func _on_pipespawner_timeout():
	var new_pipe = PIPES.instantiate()
	new_pipe.name = "pipe_"+str(Time.get_ticks_msec())
	new_pipe.position = Vector2( 200, randi_range(32, 112))
	all_pipes.add_child(new_pipe)
