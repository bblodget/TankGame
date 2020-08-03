extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hud ready!!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_tank_hit(dead_tank, live_tank):
	var score
	var score_board
	#print("A tank was hit!: ",dead_tank)
	if live_tank == "Tank1":
		score_board = $Player1Score
	else:
		score_board = $Player2Score
		
	score = score_board.text.to_int() + 1
	if score < 10:
		score_board.text = "0" + str(score)
	else:
		score_board.text = str(score)

