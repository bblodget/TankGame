extends Area2D

# Max speeds
const BULLET_SPEED = 40

# Global Vars
var velocity = Vector2.ZERO
var heading = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_velocity(new_velocity):
	velocity = new_velocity

func set_heading(new_heading):
	heading = new_heading

func _physics_process(delta):

	#velocity.x = delta * BULLET_SPEED * cos(heading * (PI/180))
	#velocity.y = delta * BULLET_SPEED * sin(heading * (PI/180))
	#move_and_collide(velocity)
	
	#if position.y < 10:
	#	queue_free()
		
	move_and_collide(velocity * delta)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
