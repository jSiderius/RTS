extends StaticBody3D

@onready var selection_ring = $SelectionRing
@onready var health_bar = %HealthBar
var health = 100.0

func _process(delta):
	health_bar.health = health

func select():
	selection_ring.visible = true
	
func deselect(): 
	selection_ring.visible = false
	
func damage(d):
	health -= d
	if health <= 0: 
		queue_free()
		get_tree().quit()

func kill(): 
	queue_free()
