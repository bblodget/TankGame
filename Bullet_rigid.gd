extends RigidBody2D

# Global Vars
var projectile_speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():	
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))


func _on_TimerBullet_timeout():
	queue_free()


func _on_Bullet_Rigid_body_entered(body):
	self.hide()
	if (body.name=="Tank1"):
		get_parent().get_node("Tank1").hit()		
	if (body.name=="Tank2"):
		get_parent().get_node("Tank2").hit()
	
