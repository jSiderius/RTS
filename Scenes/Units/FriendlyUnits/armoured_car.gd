extends Unit

@export var ac_dps = 40.0
@export var ac_speed = 40

func _ready(): 
	SPEED = ac_speed
	dps = ac_dps
		
# Handles behavior regarding the target on a per-frame basis 
# Return true to stop movement
func handle_target(delta): 
	# Check if the unit has a target and the target deleted itself
	if target and not is_instance_valid(target): 
		target = null
		return false
	
	# Check if the target exists, if so set it to our target location and make sure it is selected
	if target: 
		update_target_location(target.global_transform.origin)
		target.select()
	
	# If an attack capable unit is in distance of an existing enemy unit or enemy building target, stop moving and attack
	var in_attack_distance = target and abs(global_transform.origin.distance_to(target.global_transform.origin)) < attack_distance
	if in_attack_distance and target.is_in_group("EnemyGroundUnit"): 
		attack(delta)
		return true
	
	# Check if the target is reached 
	# Stops spamming
	# TODO: Stop spamming with multiple units
	if nav_agent.is_navigation_finished():
		return true
	return false 
		
func set_target(unit): 
	if unit == null: return 
	if not GlobalFunctions.is_in_groups(unit, ["EnemyGroundUnit"]): return 
	target = unit
	target.select() 
