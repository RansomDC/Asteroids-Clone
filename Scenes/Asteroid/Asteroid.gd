extends Area2D

var movement_vecotr := Vector2(0, -1)

enum AsteroidSize{LARGE, MEDIUM, SMALL}
@export var size := AsteroidSize.LARGE

var speed := 50

@onready var sprite = $AsteroidImage
@onready var cShape = $CollisionShape2D

func _ready():
	rotation = randf_range(0, 3*PI)
	
	match size:
		AsteroidSize.LARGE:
			speed = randf_range(50, 100)
			sprite.texture = preload("res://Assets/Images/L_Meteor.png")
			cShape.shape = preload("res://Assets/resources/asteroid_cshape_L.tres")
		AsteroidSize.MEDIUM:
			speed = randf_range(100, 150)
			sprite.texture = preload("res://Assets/Images/M_Meteor.png")
			cShape.shape = preload("res://Assets/resources/asteroid_cshape_M.tres")
		AsteroidSize.SMALL:
			speed = randf_range(100, 200)
			sprite.texture = preload("res://Assets/Images/S_Meteor.png")
			cShape.shape = preload("res://Assets/resources/asteroid_cshape_S.tres")
	
func _physics_process(delta):
	global_position += movement_vecotr.rotated(rotation) * speed * delta
	
	var radius = cShape.shape.radius
	var screen_size = get_viewport_rect().size
	if (global_position.y + radius) < 0:
		global_position.y = (screen_size.y + radius)
	elif (global_position.y - radius) > screen_size.y:
		global_position.y = -radius
	if (global_position.x + radius) < 0:
		global_position.x = (screen_size.x + radius)
	elif (global_position.x - radius) > screen_size.x:
		global_position.x = -radius


func _on_asteroid_area_entered(area):
	if area is Laser:
		area.queue_free()
		queue_free()
