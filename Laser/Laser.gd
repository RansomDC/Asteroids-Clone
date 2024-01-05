extends Area2D

@export var speed := 550.0

var movement_vector := Vector2(0, -1)

## Provide the movement for the laser, movement respects the rotational angle of the Laser Area2D
func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta

## This deletes the laser when it leaves the screen, thanks to data received from VisibleOnScreenNotifier2D
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
