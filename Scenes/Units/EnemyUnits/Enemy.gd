extends NavigationUnit
class_name Enemy

@onready var selection_ring = $SelectionRing
@onready var health_bar = %HealthBar
var health = 100.0
var health_max = 100.0
var target = null
var attack_zone = false 
var stop_zone = false
var attack_targets = []
var dps = 30
var state = "Patrol"	#States: Patrol, Defend, Attack, Push base 

var previous_position = Vector3.ZERO
var anim_moving = false
var anim_attack = false
var anim_damaged = false
var damage_anim_s = 0.4333

@export var debug_print = false
var storming_unit = false 

signal death

func _ready(): 
	super() 
	_target_death(null)
	
func _process(delta):
	# Update the health bar per frame
	health_bar.health = health
	
	var v = (global_position - previous_position) / delta
	if v.length() > 0.1: anim_moving = true
	else: anim_moving = false
	previous_position = global_position
	
	state_process()
	#_target_death(null)
	
func state_process(): 
	pass 

# Handles behavior regarding the target on a per-frame basis 
# Return true to stop movement
func handle_target(delta): 
	# Check if the unit has a target and the target deleted itself
	if target and not is_instance_valid(target): 
		#target = null
		return false
	
	# Check if the target exists, if so set it to our target location 
	if target: 
		update_target_location(target.global_transform.origin)
	
	if target and attack_zone and GlobalFunctions.is_in_groups(target, attack_targets): 
		attack(delta)
		anim_attack = true
		if stop_zone: return true
		return false
	else: 
		anim_attack = false
		
	# Check if the target is reached, stops spamming
	# TODO: Stop spamming with multiple units
	if nav_agent.is_navigation_finished():
		return true
	
	return false
	
# Selection indicator
func select():
	selection_ring.visible = true

# Deselection indicator
func deselect(): 
	selection_ring.visible = false

# Take the damage provided in the argument, if no health is remaining destruct self
# Nodes holding references to this node are responsible for using is_instance_valid() to determine this node exists
func damage(d):
	health -= d
	if health <= 0: 
		queue_free()
		
	if (health + d > 0.6 * health_max and health <= 0.6 * health_max) or (health + d > 0.3 * health_max and health <= 0.3 * health_max):
		anim_damaged = true
		await get_tree().create_timer(damage_anim_s).timeout
		anim_damaged = false 

func attack(delta): 
	# Call the targets damage function
	if target and is_instance_valid(target): 
		target.damage(dps * delta)

func set_storm(): 
	state = "Storm"
	var units = get_tree().get_nodes_in_group("AttackableFriendlyBuilding")
	var closest = null 
	var final = null
	for unit in units: 
		if (closest == null or global_position.distance_to(unit.global_position) < closest) and ((unit.is_in_group("HQ") and GlobalData.headquarters) or (unit.is_in_group("Turret") and unit.is_ready)):
			closest =  global_position.distance_to(unit.global_position)
			final = unit
	target = final 
	
func set_patrol(): 
	pass
	
func _on_detect_body_entered(body):
	if target and global_transform.origin.distance_to(target.global_transform.origin) < global_transform.origin.distance_to(body.global_transform.origin): 
		return
	for t in attack_targets: 
		if not body.is_in_group(t): continue
		target = body
		target.death.connect(_target_death) 
		state = "Attack"
		return 
	

func _on_detect_body_exited(body):
	if body == target: 
		target = null
	
		if storming_unit: 
			set_storm()
		else: 
			set_patrol() 

func _on_attack_body_entered(body):
	if body == target: attack_zone = true

func _on_attack_body_exited(body):
	if body == target: attack_zone = false

func _on_stop_body_entered(body):
	if body == target: stop_zone = true

func _on_stop_body_exited(body):
	if body == target: stop_zone = false

func _target_death(unit): 
	if unit != target: return
	
	for body in %StopRangeArea.get_overlapping_bodies(): 
		if debug_print: prints("Stop: ", body)
		for t in attack_targets: 
			if body == target or not body.is_in_group(t): continue 
			target = body
			target.death.connect(_target_death)
			attack_zone = true
			stop_zone = true
			return 
			
	for body in %AttackRangeArea.get_overlapping_bodies(): 
		if debug_print: prints("Attack: ", body)
		for t in attack_targets: 
			if body == target or not body.is_in_group(t): continue
			target = body
			target.death.connect(_target_death)
			attack_zone = true
			stop_zone = false
			return 

	for body in %DetectRangeArea.get_overlapping_bodies(): 
		if debug_print: prints("Detect: ", body)
		for t in attack_targets: 
			if body == target or not body.is_in_group(t): continue
			target = body
			target.death.connect(_target_death)
			attack_zone = false 
			stop_zone = false
			return 

	attack_zone = false 
	stop_zone = false 
	target = null 
	
