extends Node

@onready var lasers = $Lasers
@onready var player = $Player
@onready var asteroids = $Asteroids

@onready var asteroid = preload("res://Scenes/Asteroid/Asteroid.tscn")

var asteroid_scene = preload("res://Scenes/Asteroid/Asteroid.tscn")

var num_asteroids := 3
var score := 0

func _ready():
	score = 0
	
	#Laser functionality
	player.connect("laser_fired", _on_player_laser_fired)
	
	#This spawns asteroids in random positions
	for i in num_asteroids:
		var new_asteroid = asteroid.instantiate()
		new_asteroid.position = get_random_position()
		asteroids.add_child(new_asteroid)
	pass
	
	# Setup asteroids to fire a method when the "exploded" signal is received
	for asteroid in asteroids.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)

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

func _on_asteroid_exploded(pos, size, points):
	score += points
	print(score)
	for i in range(2):
		match size:
			Asteroid.AsteroidSize.LARGE:
				spawn_asteroid(pos, Asteroid.AsteroidSize.MEDIUM)
			Asteroid.AsteroidSize.MEDIUM:
				spawn_asteroid(pos, Asteroid.AsteroidSize.SMALL)
			Asteroid.AsteroidSize.SMALL:
				pass

func spawn_asteroid(pos, size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	asteroids.add_child(a)
	
	
	
	
	
	
