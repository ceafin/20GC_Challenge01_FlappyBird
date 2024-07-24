extends Node2D

const PIPES = preload("res://scenes/pipes.tscn")

@onready var bg_scene_1 = $BGScene1
@onready var bg_scene_2 = $BGScene2
@onready var pipe_spawner = $PipeSpawner
@onready var bgs = $BGs
@onready var all_pipes = $All_Pipes
@onready var score = $UI/ScoreBoard/Score
@onready var game_over_menu = $UI/GameOverMenu

var points := 0
var player_tapped_in := false

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.player_tapped_in.connect( _on_player_tapping_in )
	EventBus.get_points.connect( _on_get_points )
	EventBus.hit_pipe.connect( _on_hit_pipes )
	EventBus.game_over.connect( _on_game_over )
	pipe_spawner.connect("timeout", _on_pipespawner_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for background in bgs.get_children():
		if background.position.x < -335:
			background.position.x = 320
		
		background.position.x += -1 * delta * 45
			
	if player_tapped_in:
		for pipe in all_pipes.get_children():
			if pipe.position.x < -64:
				pipe.queue_free()
			
			pipe.position.x += -1 * delta * 75


func _on_pipespawner_timeout():
	var new_pipe = PIPES.instantiate()
	new_pipe.name = "pipe_"+str(Time.get_ticks_msec())
	new_pipe.position = Vector2( 200, randi_range(32, 112))
	all_pipes.add_child(new_pipe)

func _on_get_points():
	points += 1
	score.text = str( points )

func _on_hit_pipes():
	EventBus.game_over.emit()

func _on_game_over():
	game_over_menu.visible = true
	get_tree().paused = true


func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_player_tapping_in():
	player_tapped_in = true
	pipe_spawner.start()

