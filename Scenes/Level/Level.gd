extends Node

@onready var lasers = $Lasers
@onready var player = $Player
@onready var asteroids = $Asteroids

var num_asteroids = 3

var asteroid_scene = preload("res://Scenes/Asteroid/Asteroid.tscn")

#Commenting this our for now so that I can follow the tutorial directly, 
#not sure where or how I added this but maybe I'll need to come back to it later
#@onready var asteroid = preload("res://Scenes/Asteroid/Asteroid.tscn")

func _ready():
	#Laser functionality
	player.connect("laser_fired", _on_player_laser_fired)
	
	### Commented this out temporarily so that I could follow the tutorial ###
#	#This spawns asteroids in random positions
#	for i in num_asteroids:
#		var new_asteroid = asteroid.instantiate()
#		new_asteroid.position = get_random_position()
#		add_child(new_asteroid)
#	pass
	
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

func _on_asteroid_exploded(pos, size):
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
	
	
	
	
	
	
