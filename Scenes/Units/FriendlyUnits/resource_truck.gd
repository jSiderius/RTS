extends Unit
class_name ResourceTruck

# Update the health bar per frame
func _process(delta):
	if carrying_box and abs(global_position.distance_to(get_parent().global_position)) < 40:
		cash_box()
	
		
# Handles the outcome of a collision
func handle_collisions(collision):
	var collider = collision.get_collider()
	
	# Handles a resource truck picking up a resource collectable
	# TODO: This is a function because eventually I'll add move functionality (mesh with a box in truck bed, truck sets base as target and returns)
	if collider.is_in_group("ResourceCollectable") and not carrying_box:
		add_box(collider) 
		
#This should probably only be here 
func add_box(collider):
	print_debug("Add Box")
	var parent = get_parent()
	collider.get_parent().queue_free() 
	update_target_location(parent.global_position)
	parent.select() #There will be more logic with this, hack fix
	carrying_box = true 

func cash_box(): 
	print_debug("Drop Box")
	carrying_box = false  
	GlobalData.money += GlobalData.box_value 
	get_parent().deselect()
	update_target_location(global_position)


# Probably can take this out and set an array individually in each _ready()
func set_target(unit): 
	if unit == null: return 
	if not GlobalFunctions.is_in_groups(unit, ["ResourceCollectable"]): return 
	target = unit
	target.select() 

