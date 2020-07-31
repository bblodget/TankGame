extends RigidBody2D

# Global Vars
var projectile_speed = 400
var life_time = 0.9
var deadTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	deadTimer = Timer.new()
	deadTimer.set_wait_time(1.0)
	add_child(deadTimer)
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	SelfDestruct()
	
func SelfDestruct():
	yield(get_tree().create_timer(life_time),"timeout")
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bullet_Rigid_body_entered(body):
	#print("body: ", body.name)
	#self.hide()
	if body.name == "Tank1" or body.name == "Tank2":
		body.hide()
		deadTimer.start()
		yield(deadTimer, "timeout")
		deadTimer.stop()
		body.show()
		
