extends CharacterBody2D

signal laser_fired(laser)

@export var MAX_SPEED = 540
@export var speed = 30
@export var rotation_speed = 5
@export var rotation_direction = 0

@onready var cannon = $Cannon

var laser_scene = preload("res://Scenes/Laser/laser.tscn")

func _process(delta):
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
	
	var screen_size = get_viewport_rect().size
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0

func fire_laser():
	var l = laser_scene.instantiate()
	l.global_position = cannon.global_position
	l.rotation = rotation
	emit_signal("laser_fired", l)
	$Laser_Sound.play()
	


func _on_area_2d_area_entered(area):
	print("You hit an asteroid")
	#This will restart the level if the player touches an asteroid
	#get_tree().reload_current_scene()
