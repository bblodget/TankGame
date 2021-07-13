extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#yield($TimerSetup, "timeout")
	yield($Tank1,"ready")
	yield($Tank2,"ready")
	$Tank1.position = $SpawnPos1.position
	$Tank2.position = $SpawnPos2.position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$LPKControls.visible = false
	$RPKControls.visible = false
	$UCControls.visible = false
