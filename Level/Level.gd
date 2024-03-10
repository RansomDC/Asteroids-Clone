extends Node

@onready var lasers = $Lasers
@onready var player = $Player

func _ready():
	player.connect("laser_fired", _on_player_laser_fired)
	
func _process(delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_laser_fired(laser):
	lasers.add_child(laser)
	print("laser fired")
