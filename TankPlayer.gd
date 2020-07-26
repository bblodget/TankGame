extends KinematicBody2D


# Max speeds
const FWD_SPEED = 40
const TURN_SPEED = 90 # degrees per second


# Global Vars
var velocity = Vector2.ZERO
var heading

# Instance variables
export var tank_sprite : Texture

export var ui_left : String
export var ui_right : String
export var ui_up : String
export var ui_down : String

func _ready():
	heading = get_rotation_degrees()
	print("heading: ", heading)	
	$tank.texture = tank_sprite

func _physics_process(delta):
	var turn = TURN_SPEED * (Input.get_action_strength(ui_right) - Input.get_action_strength(ui_left))	
	
	heading = heading + (turn * delta)
	
	if turn != 0:
		set_rotation_degrees(heading)
		print("heading: ", heading)
		
	var fwd = FWD_SPEED * delta * (Input.get_action_strength(ui_down) - Input.get_action_strength(ui_up))	
	
	if fwd !=0:
		var adj_heading = heading+90
		velocity.x = fwd * cos(adj_heading * (PI/180))
		velocity.y = fwd * sin(adj_heading * (PI/180))
		print("velocity: ", velocity)
	else:
		velocity = Vector2.ZERO
	
	move_and_collide(velocity)
	
