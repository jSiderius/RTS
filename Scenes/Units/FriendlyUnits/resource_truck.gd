extends Unit
class_name ResourceTruck

var rt_attack_targets = []
var rt_other_targets = ["ResourceCollectable", "ResourceCasher"]
@export var rt_speed = 50
@export var cash_distance = 40

func _ready(): 
	attack_targets = rt_attack_targets 
	other_targets = rt_other_targets
	SPEED = rt_speed
	 
# Update the health bar per frame
func _process(delta):
	if carrying_box and abs(global_position.distance_to(get_parent().global_position)) < cash_distance:
		cash_box()
	super(delta)
	
# Handles the outcome of a collision
func handle_collisions(collision):
	var collider = collision.get_collider()
	
	# Handles a resource truck picking up a resource collectable
	if collider.is_in_group("ResourceCollectable") and not carrying_box:
		add_box(collider) 
		
#This should probably only be here 
func add_box(collider):
	var min_distance = null 
	var casher = null 
	for c in get_tree().get_nodes_in_group("ResourceCasher"): 
		var distance = global_transform.origin.distance_to(c.global_transform.origin)
		if min_distance == null or distance < min_distance: 
			min_distance = distance 
			casher = c 
	
	collider.get_parent().queue_free() 
	carrying_box = true 
	
	if casher == null: return 
	update_target_location(casher.global_transform.origin)
	target = casher
	casher.select()
	
func cash_box(): 
	#print("Cash Box")
	carrying_box = false  
	GlobalData.money += GlobalData.box_value 
	if target: target.deselect()
	target = null 
	update_target_location(global_transform.origin)
	
func set_target(unit): 
	if unit.is_in_group("ResourceCasher"):
		unit = unit.get_parent()
	var bool1 = unit == null
	var bool2 = (unit.is_in_group("ResourceCollectable") and carrying_box)
	var bool3 = (unit.is_in_group("ResourceCasher") and not carrying_box)
	var bool4 = not GlobalFunctions.is_in_groups(unit, attack_targets + other_targets)
	if  bool1 or bool2 or bool3 or bool4: return 
	target = unit
	target.select() 


