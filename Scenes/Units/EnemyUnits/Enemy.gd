extends StaticBody3D

@onready var selection_ring = $SelectionRing
@onready var health_bar = %HealthBar
@export var moving = false
var SPEED = 3.0
var health = 100.0

func _process(delta):
	health_bar.health = health
	
func _physics_process(delta):
	if(moving):
		global_transform.origin += SPEED * delta * Vector3(-1.0, 0.0, 0.0)

func select():
	print("EnemySelect()")
	selection_ring.visible = true
	
func deselect(): 
	selection_ring.visible = false
	
func damage(d):
	health -= d
	if health <= 0: 
		queue_free()

func kill(): 
	queue_free()

