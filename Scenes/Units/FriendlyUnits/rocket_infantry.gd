extends Unit

@export var ri_upgrade_dps = 40.0
@export var ri_dps = 20.0
@export var ri_attack_distance = 200.0
var ri_attack_targets = ["EnemyAirUnit", "EnemyBuilding"]
var ri_other_targets = ["HealthCollectable", "WeaponUpgradeCollectable"]

func _ready(): 
	dps = ri_dps
	attack_distance = ri_attack_distance 
	attack_targets = ri_attack_targets
	other_targets = ri_other_targets 
	
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
		dps += ri_upgrade_dps # Change damage stats
		collider.get_parent().queue_free() # Remove collectable from the queue
		

