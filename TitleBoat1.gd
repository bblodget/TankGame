extends KinematicBody2D


# Max speeds
const FWD_SPEED = 100

# Global Vars
var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):

	# Move Up
	velocity.y = -FWD_SPEED * delta 
	
	move_and_collide(velocity)
	


func _on_Screen_Exit_body_entered(body):
	if body == self:
		queue_free()
