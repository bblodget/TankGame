extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Max speeds
const FWD_SPEED = 20

# Global Vars
var velocity = Vector2.ZERO

var move_text = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x
	if move_text == true:
		velocity.x = FWD_SPEED * delta 
		
		x = $at_label.rect_position.x
		$at_label.rect_position.x = x + velocity.x
		
		x = $Comb_label.rect_position.x
		$Comb_label.rect_position.x = x - velocity.x


func _on_Title_Area_body_entered(body):
	if body == $TitleBoat1:
		print("Boat1 entered Title Area")
		move_text = true

func _on_Title_Area_body_exited(body):
	print("Boat exited Title Area")
	move_text = false
	$ShootTimer.start()
	$TitleBoat2.move_boat = true
