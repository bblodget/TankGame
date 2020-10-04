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
	$Lifesaver.visible = false


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
		move_text = true

func _on_Title_Area_body_exited(body):
	move_text = false
	$ShootTimer.start()
	$TitleBoat2.move_boat = true
	if body == $TitleBoat2:
		$Lifesaver.visible = true
		$GameTimer.start()


func _on_GameTimer_timeout():
	# Show Boats or Tanks Selection
	$TankSelection.visible = true
	$BoatSelection.visible = true
	$TanksOrBoats.visible = true
	
	
	
func start_game():
	# Remove the Title scene
	var myroot = get_tree().get_root()
	var tscreen = myroot.get_node("TitleScreen")
	myroot.remove_child(tscreen)
	tscreen.call_deferred("free")
	
	# Add the world scene
	var scale = Vector2(0.5, 0.5)
	var world_scene = load("res://World.tscn")
	var world = world_scene.instance()
	
	world.get_node("Tank1").tank_sprite = load("res://dg_tank.png")
	world.get_node("Tank1").initial_heading = 0
	world.get_node("Tank1").scale = scale
	
	world.get_node("Tank2").tank_sprite = load("res://orange_tank.png")
	world.get_node("Tank2").initial_heading = 0
	world.get_node("Tank2").scale = scale
	
	myroot.add_child(world)
	VisualServer.set_default_clear_color(Color(0.3,0.3,0.3,1.0))

	
	#world.Tank1.tank_sprite = "res://dg_tank.png"
	#world.Tank2.tank_sprite = "res://orange_tank.png"
	# get_tree().change_scene(world)
	#owner.add_child(world)
