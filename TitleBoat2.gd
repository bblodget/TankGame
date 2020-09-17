extends KinematicBody2D


# Max speeds
const FWD_SPEED = 100

# Global Vars
var velocity = Vector2.ZERO

var move_boat = false
var bullet_scene = preload("res://Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):

	if move_boat == true:
		# Move Up
		velocity.y = -FWD_SPEED * delta 
		
		move_and_collide(velocity)
		
func shoot():
	
	
	var direction = Vector2(0, -1)
	var distance_from_me = 40
	var gpos = get_global_position() 
	print("gpos: ", gpos, "direction: ", direction)
	var spawn_point = gpos + (direction * distance_from_me)
	
	var bullet = bullet_scene.instance()
	bullet.set_global_position(spawn_point)
	bullet.rotation = (0 - 90)* (PI/180)
	owner.add_child(bullet)
	
	#if play_sound == true:
	#	$SoundFire.playing = true


func _on_ShootTimer_timeout():
	shoot()
