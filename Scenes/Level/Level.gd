extends Node

@onready var lasers = $Lasers
@onready var player = $Player

var num_asteroids = 3
@onready var asteroid = preload("res://Scenes/Asteroid/Asteroid.tscn")

func _ready():
	#Laser functionality
	player.connect("laser_fired", _on_player_laser_fired)
	
	#Spawn asteroids
	for i in num_asteroids:
		var new_asteroid = asteroid.instantiate()
		new_asteroid.position = get_random_position()
		add_child(new_asteroid)
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_laser_fired(laser):
	lasers.add_child(laser)

func get_random_position():
	randomize()
	#return a random screen position
	var v = Vector2(randf_range(0, 1024), randf_range(0,600))
	return v
