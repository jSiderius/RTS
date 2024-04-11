extends CharacterBody3D
class_name NavigationUnit

@onready var nav_agent = $NavigationAgent3D

# Classes will typically reset these variables 
var SPEED = 20.0 
var rotation_speed = 10.0 

func _ready():
	await get_tree().physics_frame
	nav_agent.path_desired_distance = 1.0
	nav_agent.debug_enabled = true
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta: float): 
	# Handling the target is called from physics process because depending on the current state we may want to not move
	if handle_target(delta): return
		
	# Calculate the velocity based on the current path
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position() 
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity

	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), delta * rotation_speed)
	
	# Check for collisions
	var collision = move_and_collide(new_velocity * delta)
	if collision: handle_collisions(collision)

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)	
	#$NavigationAgent3D.set_target_position(target_location)	

func handle_target(delta): 
	return false 

func handle_collisions(col): 
	return 
