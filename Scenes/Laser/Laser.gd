extends Area2D
class_name Laser

@export var speed := 550.0

var movement_vector := Vector2(0, -1)

## Provide the movement for the laser, movement respects the rotational angle of the Laser Area2D
func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	
	var screen_size = get_viewport_rect().size
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0

### This deletes the laser when it leaves the screen, thanks to data received from VisibleOnScreenNotifier2D
#func _on_visible_on_screen_notifier_2d_screen_exited():
#	queue_free()


func _on_timer_timeout():
	queue_free()
