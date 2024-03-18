extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var selection_ring = $SelectionRing
@onready var health_bar = %HealthBar

@export var SPEED = 20.0 
@export var dps = 40.0

var target = null # Keeps track of the target
var attack_distance = 30.0	# Distance a unit needs to be from a target to attack, eventually will be exported but this is all I need now
var health = 50.0 # Starting health of the unit, eventually will be exported but this is all I need now
var health_pickup = 50.0 # Determines the amount of health restored from a health collectable
var weapon_pickup = 40.0 # Determines the amount of damage added from a weapon upgrade collectable

# Shows the navigation lines on the screen, can turn this off here but I find them satisfying so they're in the prototype at least
func _ready():
	nav_agent.debug_enabled = true

# Update the health bar per frame
func _process(delta):
	health_bar.health = health

func _physics_process(delta): 
	# Handling the target is called from physics process because depending on the current state we may want to not move
	if handle_target(delta): return
		
	# Calculate the velocity based on the current path
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position() 
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	
	# Check for collisions
	var collision = move_and_collide(new_velocity * delta)
	if collision: handle_collisions(collision)
		
# Handles behavior regarding the target on a per-frame basis 
# Return true to stop movement
func handle_target(delta): 
	# Check if the unit has a target and the target deleted itself
	if target and not is_instance_valid(target): 
		target = null
	
	# Check if the target exists, if so set it to our target location and make sure it is selected
	if target: 
		update_target_location(target.global_transform.origin)
		target.select()
	
	# If an attack capable unit is in distance of an existing enemy unit or enemy building target, stop moving and attack
	var in_attack_distance = target and abs(global_transform.origin.distance_to(target.global_transform.origin)) < attack_distance
	if in_attack_distance and is_in_group("AttackingUnit") and GlobalFunctions.is_in_groups(target, ["EnemyUnit", "EnemyBuilding"]): 
		attack(delta)
		return true
	
	# Check if the target is reached 
	# Stops spamming
	# TODO: Stop spamming with multiple units
	if nav_agent.is_target_reached(): 
		return true
		
# Handles the outcome of a collision
func handle_collisions(collision):
	var collider = collision.get_collider()
	
	# Handles a resource truck picking up a resource collectable
	# TODO: This is a function because eventually I'll add move functionality (mesh with a box in truck bed, truck sets base as target and returns)
	if collider.is_in_group("ResourceCollectable") and is_in_group("ResourceTruck"):
		add_box(collider) 
		
	# Handles a healable unit picking up a health collectable
	if collider.is_in_group("HealthCollectable") and is_in_group("HealableUnit") and health < 100:
		collider.get_parent().queue_free() 
		health += health_pickup
	
	# Handles a weapon upgradeable unit getting a weapon upgrad
	if collider.is_in_group("WeaponUpgradeCollectable") and is_in_group("WeaponUpgradeUnit"): 
		# Unit already has an upgrade
		if %HeavyWeapon.visible: 
			return 
		%HeavyWeapon.visible = true # Change weapon visibility
		%LightWeapon.visible = false # Change weapon visibility
		dps += weapon_pickup # Change damage stats
		collider.get_parent().queue_free() # Remove collectable from the queue

func attack(delta): 
	# Call the targets damage function
	if target: 
		target.damage(dps * delta)

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)	

func add_box(collider):
	collider.get_parent().queue_free() 
	GlobalData.money += 100  

func select(): 
	selection_ring.visible = true
	
func deselect(): 
	selection_ring.visible = false

func set_target(unit): 
	target = unit
	target.select() 
	
func clear_target():
	if target: 
		target.deselect()
	target = null 
