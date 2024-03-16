extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var selection_ring = $SelectionRing
var SPEED = 20.0 

func _ready():
	nav_agent.debug_enabled = true
	
func update_target_location(target_location):
	print("update_target_location()")
	nav_agent.set_target_position(target_location)	

func _physics_process(delta): 
	if nav_agent.is_target_reached(): 
		#move_and_slide() not nav_agent.is_target_reachable() or
		return
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position() 
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	move_and_slide()

func select(): 
	selection_ring.visible = true
	
func deselect(): 
	selection_ring.visible = false
