extends KinematicBody2D


# Max speeds
const FWD_SPEED = 40
const TURN_SPEED = 90 # degrees per second


# Global Vars
var velocity = Vector2.ZERO
var heading
var adj_heading
var fire = 0
var last_fire = 0
var can_fire = true
var rate_of_fire = 0.4
var bullet_scene = preload("res://Bullet.tscn")

# Instance variables
export var tank_sprite : Texture

export var ui_left : String
export var ui_right : String
export var ui_up : String
export var ui_down : String
export var ui_fire : String
export var initial_heading : float = 0.0

func _ready():
	heading = get_rotation_degrees()
	$tank.texture = tank_sprite

func _physics_process(delta):
		
	var turn = TURN_SPEED * (Input.get_action_strength(ui_right) - Input.get_action_strength(ui_left))	
	
	heading = heading + (turn * delta)
	adj_heading = heading + initial_heading
	
	if turn != 0:
		set_rotation_degrees(heading)
		
	fire = Input.get_action_strength(ui_fire)
	if (fire==1) and (can_fire == true) and (last_fire==0):
		can_fire = false
		shoot()	
		#yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
	last_fire = fire


		
	var fwd = FWD_SPEED * delta * (Input.get_action_strength(ui_down) - Input.get_action_strength(ui_up))	
	
	if fwd !=0:
		velocity.x = (-fwd) * sin(adj_heading * (PI/180))
		velocity.y = fwd * cos(adj_heading * (PI/180))

	else:
		velocity = Vector2.ZERO
	
	move_and_collide(velocity)
	
	
func shoot():
	
	var direction = Vector2(sin(adj_heading * (PI/180)), -cos(adj_heading * (PI/180)))
	
	var distance_from_me = 10
	var gpos = get_global_position() 
	print("gpos: ", gpos, "direction: ", direction, "adj_heading: ", adj_heading)
	var spawn_point = gpos + (direction * distance_from_me)
	
	var bullet = bullet_scene.instance()
	bullet.set_global_position(spawn_point)
	bullet.rotation = (adj_heading - 90)* (PI/180)
	print("heading: ", heading)
	print("adj_heading: ", adj_heading)
	owner.add_child(bullet)
	

	
	#bullet.set_velocity(direction * 100)
	#bullet.transform = transform
	
	
	#var world = get_tree().get_root().get_node("World")
	
	#bullet.transform = world.transform
	#add_child_below_node(world, bullet)
	
func hit():
	print("I'm hit: ",self.name)
	self.hide()
	$TimerHidden.start()
	

func _on_TimerHidden_timeout():
	$TimerHidden.stop()
	self.show()
