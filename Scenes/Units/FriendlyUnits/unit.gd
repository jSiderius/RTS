extends NavigationUnit
class_name Unit

@onready var selection_ring = $SelectionRing
@onready var health_bar = %HealthBar

@export var dps = 40.0

var target = null # Keeps track of the target
var attack_distance = 30.0	# Distance a unit needs to be from a target to attack, eventually will be exported but this is all I need now
var health = 100.0 # Starting health of the unit, eventually will be exported but this is all I need now
var health_pickup = 50.0 # Determines the amount of health restored from a health collectable
var weapon_pickup = 40.0 # Determines the amount of damage added from a weapon upgrade collectable
var carrying_box = false

var attack_targets : Array = []
var other_targets : Array = []

func _ready():
	pass

# Update the health bar per frame
func _process(delta):
	health_bar.health = health

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
	
	var in_attack_distance = target and abs(global_transform.origin.distance_to(target.global_transform.origin)) < attack_distance
	if  in_attack_distance and GlobalFunctions.is_in_groups(target, attack_targets): 
		attack(delta)
		return true
	
	# Check if the target is reached, stops spamming
	# TODO: Stop spamming with multiple units
	if nav_agent.is_navigation_finished():
		return true
	
	return false
	
# Handles the outcome of a collision
func handle_collisions(collision):
	pass

func attack(delta): 
	# Call the targets damage function
	if target and is_instance_valid(target): 
		target.damage(dps * delta)

signal death
func damage(d):
	health -= d
	if health <= 0: 
		#queue_free()
		emit_signal("death", self)

func select(): 
	selection_ring.visible = true
	
func deselect(): 
	selection_ring.visible = false

func set_target(unit): 
	print("Set Target")
	
	if unit == null: return 
	if not GlobalFunctions.is_in_groups(unit, attack_targets + other_targets): return 
	target = unit
	target.select() 
	
func clear_target():
	if target and is_instance_valid(target): 
		target.deselect()
	target = null 
