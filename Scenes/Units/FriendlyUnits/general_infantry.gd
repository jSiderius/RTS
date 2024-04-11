extends Unit

@export var gi_upgrade_dps = 40.0
@export var gi_dps = 40.0
@export var gi_speed = 30.0
var gi_attack_targets = ["EnemyGroundUnit", "EnemyBuilding"] 
var gi_other_targets = ["HealthCollectable", "WeaponUpgradeCollectable"]

func _ready(): 
	dps = gi_dps
	attack_targets = gi_attack_targets
	other_targets = gi_other_targets 
	SPEED = gi_speed
	health = 100
	
# Handles the outcome of a collision
func handle_collisions(collision):
	var collider = collision.get_collider()
	
	# Handles a healable unit picking up a health collectable
	if collider.is_in_group("HealthCollectable") and health < 100:
		collider.get_parent().queue_free() 
		health += health_pickup
	
	# TODO Boxes randomly disapear??
	# Handles a weapon upgradeable unit getting a weapon upgrad
	if collider.is_in_group("WeaponUpgradeCollectable"): 
		# Unit already has an upgrade
		if %HeavyWeapon.visible: 
			return 
		%HeavyWeapon.visible = true # Change weapon visibility
		%LightWeapon.visible = false # Change weapon visibility
		dps += gi_upgrade_dps # Change damage stats
		collider.get_parent().queue_free() # Remove collectable from the queue
		
