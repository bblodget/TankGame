extends Node2D

# Global Vars


# Export vars
export var win_score : int
export var GREEN : Color = Color(0.19, 0.67, 0.17, 1.0)
export var ORANGE : Color = Color(0.83, 0.72, 0.16, 1.0)



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
		
	if score == win_score:
		if live_tank == "Tank1":
			#$PlayerWins.set("custom_colors/font_color",GREEN)
			$PlayerWins.add_color_override("font_color", GREEN)
			$PlayerWins.text = "Green Wins"
		else:
			#$PlayerWins.set("custom_colors/font_color",ORANGE)
			$PlayerWins.add_color_override("font_color", ORANGE)
			$PlayerWins.text = "Orange Wins"
		$PlayerWins.show()
		$GameOver.show()

