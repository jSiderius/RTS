extends StaticBody3D
class_name Enemy

@onready var selection_ring = $SelectionRing
@onready var health_bar = %HealthBar
@export var moving = false
var SPEED = 3.0
var health = 100.0

func _process(delta):
	# Update the health bar per frame
	health_bar.health = health
	
# Very simple movement to demonstrate units targeting enemies will continue to follow movement
func _physics_process(delta):
	if(moving):
		global_transform.origin += SPEED * delta * Vector3(-1.0, 0.0, 0.0)

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
