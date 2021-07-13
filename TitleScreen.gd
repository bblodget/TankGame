extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Max speeds
const FWD_SPEED = 20

# Global Vars
var velocity = Vector2.ZERO
var move_text = false

# Selection controls
export var ui_left : String
export var ui_right : String
export var ui_accept : String


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
		
	if $CampaignSelection.visible:
		var LRselected = (Input.get_action_strength(ui_right) - Input.get_action_strength(ui_left))	
		if LRselected > 0.1:
			$CoopSelection.frame = 0
			$CampaignSelection.frame = 1
			
		if LRselected < -0.1 :
			$CoopSelection.frame = 1
			$CampaignSelection.frame = 0
			
		if Input.get_action_strength(ui_accept) == 1:
			$TransitionTimer.start()
			$TanksOrBoats.visible = true
			$CampaignSelection.visible = false
			$Campaign.visible = false
			$CoopSelection.visible = false
		
	if $BoatSelection.visible:
		var LRselected = (Input.get_action_strength(ui_right) - Input.get_action_strength(ui_left))	
		if LRselected > 0.1:
			$TankSelection.frame = 0
			$BoatSelection.frame = 1
			
		if LRselected < -0.1 :
			$TankSelection.frame = 1
			$BoatSelection.frame = 0
			
		if Input.get_action_strength(ui_accept) == 1:
			start_game($TankSelection.frame, $CampaignSelection.frame)


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


func _on_TransitionTimer_timeout():
	$BoatSelection.visible = true
	$TankSelection.visible = true

func _on_GameTimer_timeout():
	# Show Boats or Tanks Selection
	#$TankSelection.visible = true
	#$BoatSelection.visible = true
	#$TanksOrBoats.visible = true
	$CampaignSelection.visible = true
	$Campaign.visible = true
	$ControlsPrompt.visible = true
	$CoopSelection.visible = true
	
	
func start_game(isTankSelected, isCampaignSelected):
	# Remove the Title scene
	var myroot = get_tree().get_root()
	var tscreen = myroot.get_node("TitleScreen")
	myroot.remove_child(tscreen)
	tscreen.call_deferred("free")
	
	# Add the world scene
	var worldNum = isCampaignSelected
	var world_scene
	if worldNum == 0:
		world_scene = load("res://Campaign.tscn")
	if worldNum == 1:
		world_scene = load("res://World.tscn")
	var scale = Vector2(0.5, 0.5)
	var world = world_scene.instance()
	#var mts = load("res://MirrorTank.tscn")
	#var mt = mts.instance()
	
	if isTankSelected==1:
		world.get_node("Tank1").tank_sprite = load("res://dg_tank.png")
		world.get_node("Tank1").initial_heading = 0
		world.get_node("Tank1").scale = scale
		
		world.get_node("Tank2").tank_sprite = load("res://orange_tank.png")
		world.get_node("Tank2").initial_heading = 0
		world.get_node("Tank2").scale = scale
		VisualServer.set_default_clear_color(Color(0.3,0.3,0.3,1.0))
		
		#mt.get_node("MirrorTank").tank_sprite = load("res://orange_tank.png")
		#mt.get_node("MirrorTank").initial_heading = 0
		#mt.get_node("MirrorTank").scale = scale
	else:
		scale = Vector2(1.0, 1.0)
		world.get_node("Tank1").tank_sprite = load("res://boat_guy_still.png")
		world.get_node("Tank1").initial_heading = 90
		world.get_node("Tank1").scale = scale
		
		world.get_node("Tank2").tank_sprite = load("res://boat_guy_still2.png")
		world.get_node("Tank2").initial_heading = 90
		world.get_node("Tank2").scale = scale
		
		#mt.get_node("MirrorTank").tank_sprite = load("res://boat_guy_still2.png")
		#mt.get_node("MirrorTank").initial_heading = 90
		#mt.get_node("MirrorTank").scale = scale
		
	myroot.add_child(world)
		
