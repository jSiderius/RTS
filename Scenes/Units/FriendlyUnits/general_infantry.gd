extends Unit

@export var gi_upgrade_dps = 40.0
@export var gi_dps = 40.0

func _unit_ready(): 
	dps = gi_dps
	
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
	if  GlobalFunctions.is_in_groups(target, ["EnemyUnit", "EnemyBuilding"]): 
		attack(delta)
		return true
	
	# Check if the target is reached, stops spamming
	if nav_agent.is_navigation_finished():
		return true
	return false 
	
# Handles the outcome of a collision
func handle_collisions(collision):
	var collider = collision.get_collider()
	
	# Handles a healable unit picking up a health collectable
	if collider.is_in_group("HealthCollectable") and health < 100:
		collider.get_parent().queue_free() 
		health += health_pickup
	
	#TODO Boxes randomly disapear??
	# Handles a weapon upgradeable unit getting a weapon upgrad
	if collider.is_in_group("WeaponUpgradeCollectable"): 
		# Unit already has an upgrade
		if %HeavyWeapon.visible: 
			return 
		%HeavyWeapon.visible = true # Change weapon visibility
		%LightWeapon.visible = false # Change weapon visibility
		dps += gi_upgrade_dps # Change damage stats
		collider.get_parent().queue_free() # Remove collectable from the queue
