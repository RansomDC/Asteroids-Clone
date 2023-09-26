extends CharacterBody2D


const SPEED = 30

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		velocity.y -= SPEED
	
	move_and_slide()
