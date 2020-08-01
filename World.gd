extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tank1/StartPosition.position.x = 300
	$Tank1/StartPosition.position.y = 95
	$Tank2/StartPosition.position.x = 15
	$Tank2/StartPosition.position.y = 95
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
