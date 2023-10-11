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
		accelerate()


func accelerate():
	if (velocity.length() < abs(500)):
		velocity.y += transform.y.y * -speed
		velocity.x += transform.y.x * -speed
	else:
		if ((velocity.y < 0 && transform.y.y <= 0) || (velocity.y > 0 && transform.y.y > 0) || (velocity.x > 0 && transform.y.x > 0) || (velocity.x < 0 && transform.y.x <= 0)):
			velocity.y += transform.y.y * -speed
			velocity.x += transform.y.x * -speed

		#Here we say, you can only add velocity in directions other than the current ones
		




	
func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	
	print("vvv")
	print("transform.y: {0}, \ntransform.x: {1}, \nvelocity: {2} \nlength: {3}".format([transform.y.y, transform.y.x, velocity, velocity.length()], "{_}"))
	print("^^^")
	
	var screen_size = get_viewport_rect().size
	
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0
