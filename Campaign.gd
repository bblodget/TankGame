extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield($Tank1,"ready")
	yield($Tank2,"ready")
	$Tank1.position = $SpawnPos1.position
	$Tank2.position = $SpawnPos2.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if $Controls.visible == true:
		#$TextTimeout.start()
#	pass


func _on_TextTimeout_timeout():
	$Tank1/Player.visible = false 
	$Tank2/Enemy.visible = false
	$Controls.visible = false


func _on_Area2D_body_entered(body):
	if body == $Tank2:
		$aWinnerIsU.visible = true
		$WinScreen.start()


func _on_WinScreen_timeout():
	var myroot = get_tree().get_root()
	var tscreen = myroot.get_node("Campaign")
	myroot.remove_child(tscreen)
	tscreen.call_deferred("free")
	
	# Add the world scene
	var world_scene = load("res://TitleScreen.tscn")
	var world = world_scene.instance()
	myroot.add_child(world)
