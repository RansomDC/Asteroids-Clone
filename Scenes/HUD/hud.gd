extends Control

@onready var score = $Score:
	set(value):
		score.text = "Score: " + str(value)

@onready var lives = $Lives:
	set(value):
		lives.text = "Lives: " + str(value)

var uiLife_scene = preload("res://Scenes/UILife/Ui_Life.tscn")

@onready var livesContainer = $LivesContainer

func init_lives(amount):
	for ul in livesContainer.get_children():
		ul.queue_free()
	
	for i in amount:
		var ul = uiLife_scene.instantiate()
		livesContainer.add_child(ul)
