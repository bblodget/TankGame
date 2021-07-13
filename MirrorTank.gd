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
var enemy_tank
var hud
var game_over = false
var play_sound = false


# Custom Signals
signal tank_hit(dead_tank, live_tank)

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
	if self.name=="Tank1":
		enemy_tank = owner.get_node("Tank2")
		play_sound = true
	else: 
		enemy_tank = owner.get_node("Tank1")
		play_sound = true
		
	print("enemy_tank: ",enemy_tank.name)
	
	
	$ExplosionAnim.hide()
	
	#hud = owner.get_node("Score")
	#print("hud name: ",hud.name)
	#print("wait for hud..")
	#yield(hud,"ready")
	#print("hud ready")
	#var error = self.connect("tank_hit", hud, "_on_tank_hit")
	#print("connect error: ", error)
	
	if play_sound == true:
		$SoundIdle.playing = true
		$SoundMove.playing = true
		$SoundFire.playing = false
		$SoundExplosion.playing = false
		
		$SoundIdle.set_stream_paused(false)
		$SoundMove.set_stream_paused(true)
	
		
	
	#$SoundIdle.set_stream_paused(true)
	#$SoundMove.set_stream_paused(true)

func set_game_over(is_over):
	game_over = is_over
	$SoundIdle.playing = false
	$SoundMove.playing = false
	$SoundFire.playing = false
	$SoundExplosion.playing = false
	
	

func _physics_process(delta):
	
	if not $tank.visible or game_over:
		return
		
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
		# Moving
		velocity.x = (-fwd) * sin(adj_heading * (PI/180))
		velocity.y = fwd * cos(adj_heading * (PI/180))
		if play_sound == true:
			$SoundIdle.set_stream_paused(true)
			$SoundMove.set_stream_paused(false)

	else:
		# Stopped
		velocity = Vector2.ZERO
		if play_sound == true:
			$SoundMove.set_stream_paused(true)
			$SoundIdle.set_stream_paused(false)
		
	
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
	
	if play_sound == true:
		$SoundFire.playing = true
		

	
	#bullet.set_velocity(direction * 100)
	#bullet.transform = transform
	
	
	#var world = get_tree().get_root().get_node("World")
	
	#bullet.transform = world.transform
	#add_child_below_node(world, bullet)
	
func hit():
	if not $ExplosionAnim.is_playing() and not game_over:
		print("I'm hit: ",self.name)
		emit_signal("tank_hit", self, enemy_tank)
		if play_sound == true:
			$SoundExplosion.playing = true
		$tank.hide()
		$ExplosionAnim.show()
		$ExplosionAnim.play()
	
	

func _on_ExplosionAnim_animation_finished():
	$ExplosionAnim.stop()
	$ExplosionAnim.hide()
	print("I'm back!!: ",self.name)
	#self.position = $StartPosition.position
	#var dist1 = enemy_tank.global_position.distance_to(owner.get_node("SpawnPos1").position)
	#var dist2 = enemy_tank.global_position.distance_to(owner.get_node("SpawnPos2").position)
	#if dist1 > dist2:
		#self.position = owner.get_node("SpawnPos1").position 
	#else:
		#self.position = owner.get_node("SpawnPos2").position
	self.position = owner.get_node("DefeatBox").position
	$tank.show()


func _on_SoundFire_finished():
	$SoundFire.playing = false
	$SoundFire.seek(0.0)
	print("Fire Finsihed!!!!")


func _on_SoundExplosion_finished():
	$SoundExplosion.playing = false
	$SoundExplosion.seek(0.0)
