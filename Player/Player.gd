extends CharacterBody2D


const SPEED = 5

@export var speed = 45
@export var rotation_speed = 6

var maxSpeed = 300
var rotation_direction = 0
var gp = global_position

func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	if (Input.is_action_pressed("ui_up")):
		velocity.y += transform.y.y * -speed
		velocity.x += transform.y.x * -speed


func accelerate():
	if (velocity.length() < 500):
		get_input()
	else:
		if (velocity.y < 0):
			if (transform.y.y > 0):
				get_input()

		#Here we say, you can only add velocity in directions other than the current ones
		
		print("vvv")
		print(velocity)
		print(transform.y)
		print(transform.x)
		print("^^^")



	
func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	print(velocity)
	
	var screen_size = get_viewport_rect().size
	
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0
