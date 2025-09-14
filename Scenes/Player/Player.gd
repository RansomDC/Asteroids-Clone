class_name Player extends CharacterBody2D

signal laser_fired(laser)
signal died

@export var MAX_SPEED = 540
@export var speed = 30
@export var rotation_speed = 5
@export var rotation_direction = 0
@export var ship_size = 45

@onready var cannon = $Cannon
@onready var cShape = $ShipArea2D/ShipCollisionPoly
@onready var sprite = $ShipImage

var laser_scene = preload("res://Scenes/Laser/laser.tscn")

var alive = true

func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		fire_laser()

func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	if (Input.is_action_pressed("ui_up")):
		accelerate()


func accelerate():
		velocity.y += transform.y.y * -speed
		velocity.x += transform.y.x * -speed
		velocity = velocity.limit_length(MAX_SPEED)

	
func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	
	move_and_slide()
	
	var radius = ship_size
		
	var screen_size = get_viewport_rect().size
	if (global_position.y + radius) < 0:
		global_position.y = (screen_size.y + radius)
	elif (global_position.y - radius) > screen_size.y:
		global_position.y = -radius
	if (global_position.x + radius) < 0:
		global_position.x = (screen_size.x + radius)
	elif (global_position.x - radius) > screen_size.x:
		global_position.x = -radius

func fire_laser():
	var l = laser_scene.instantiate()
	l.global_position = cannon.global_position
	l.rotation = rotation
	emit_signal("laser_fired", l)
	$Laser_Sound.play()

func die():
	# This makes it so that we can't die more than once.
	if alive == true:
		alive = false
		emit_signal("died")
		#This deletes the player
		#queue_free()
		
		#This, instead, disables the sprite and makes the player inactive
		sprite.visible = false
		process_mode = Node.PROCESS_MODE_DISABLED

func _on_area_2d_area_entered(area):
	if area is Asteroid:
		die()
		
func respawn(pos):
	if !alive:
		alive = true
		global_position = pos
		#This makes sure we don't have velocity when the player spawns
		velocity = Vector2.ZERO
		
		#These re-enable the Player
		sprite.visible = true
		process_mode = Node.PROCESS_MODE_INHERIT
