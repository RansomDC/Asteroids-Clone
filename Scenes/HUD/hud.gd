extends Control

@onready var score = $Score:
	set(value):
		score.text = "Score: " + str(value)

@onready var lives = $Lives:
	set(value):
		lives.text = "Lives: " + str(value)
