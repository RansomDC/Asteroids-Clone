extends CharacterBody2D


const SPEED = 2
const MAX_SPEED = 1000
@export var speed = 45
@export var rotation_speed = 5
var rotation_direction = 0


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
