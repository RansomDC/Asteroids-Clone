class_name Level extends Node

@onready var lasers = $Lasers
@onready var player = $Player
@onready var asteroids = $Asteroids
@onready var hud = $UI/HUD
@onready var gameOverScreen = $UI/GameOverScreen
@onready var livesContainer = $UI/HUD/LivesContainer
@onready var playerSpawn = $PlayerSpawnPos

@onready var asteroid = preload("res://Scenes/Asteroid/Asteroid.tscn")

var asteroid_scene = preload("res://Scenes/Asteroid/Asteroid.tscn")
var player_scene = preload("res://Scenes/Player/Player.tscn")
var life_icon = preload("res://Scenes/UILife/Ui_Life.tscn")

var num_asteroids := 3
var _score := 0 
var _lives := 3

var score:
	set(value):
		_score = value
		hud.score = _score
#	Ideally I would use:
#		set(value):
#			field = value
#			hud.score = field
#	but the field keyword is not working. It should work in Godot 4.x.x, so I'm not sure what's going on.
	get:
		return _score

var lives:
	set(value):
		_lives = value
		hud.lives = _lives
		hud.init_lives(_lives)
	get:
		return _lives

func _ready():
	gameOverScreen.visible = false
	score = 0
	lives = 3
	hud.init_lives(_lives)
	
	#Laser functionality
	#player.connect("laser_fired", _on_player_laser_fired)
	player.connect("died", _on_player_died)
	
	#This spawns asteroids in random positions
	for i in num_asteroids:
		var new_asteroid = asteroid.instantiate()
		new_asteroid.position = get_random_position()
		asteroids.add_child(new_asteroid)
	pass
	
	# Setup asteroids to fire a method when the "exploded" signal is received
	for a in asteroids.get_children():
		a.connect("exploded", _on_asteroid_exploded)

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_laser_fired(laser):
	lasers.add_child(laser)
	$Laser_Sound.play()

func get_random_position():
	randomize()
	#return a random screen position
	var v = Vector2(randf_range(0, 1024), randf_range(0,600))
	return v

func _on_asteroid_exploded(pos, size, points):
	score += points
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
	asteroids.call_deferred("add_child", a)
#	We were using the following, but was getting an error that suggested using call_defered here would be better
#	asteroids.add_child(a)
	
	
func _on_player_died():
	lives -= 1
	if lives <= 0:
		await get_tree().create_timer(2).timeout
		gameOverScreen.visible = true
#		get_tree().reload_current_scene()
	else:
		await get_tree().create_timer(1).timeout
		player.respawn(playerSpawn.global_position)

func _restart_game():
	get_tree().reload_current_scene()







