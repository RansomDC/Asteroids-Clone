extends Node

@onready var lasers = $Lasers
@onready var player = $Player

func _ready():
	player.connect("laser_fired", _on_player_laser_fired)


func _on_player_laser_fired(laser):
	lasers.add_child(laser)
	print("laser fired")
