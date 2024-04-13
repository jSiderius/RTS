extends Unit

@export var gi_upgrade_dps = 40.0
@export var gi_dps = 40.0
@export var gi_speed = 30.0
var gi_attack_targets = ["EnemyGroundUnit", "EnemyBuilding"] 
var gi_other_targets = ["HealthCollectable", "WeaponUpgradeCollectable"]
@onready var animation_tree = $CharacterArmature/AnimationTree

func _ready(): 
	dps = gi_dps
	attack_targets = gi_attack_targets
	other_targets = gi_other_targets 
	SPEED = gi_speed
	health = 100
	
func _process(delta): 
	_process_animation(delta)
	super(delta) 
	
func _process_animation(delta): 
	if anim_moving: 
		animation_tree.set("parameters/walking/transition_request", "true")
	else: 
		animation_tree.set("parameters/walking/transition_request", "false")
	if anim_attack: 
		animation_tree.set("parameters/attacking/transition_request", "true")
	else: 
		animation_tree.set("parameters/attacking/transition_request", "false")
	if anim_damaged: 
		animation_tree.set("parameters/damaged/transition_request", "true")
	else: 
		animation_tree.set("parameters/damaged/transition_request", "false")
	
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
		
