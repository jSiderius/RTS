extends Node3D
class_name Building

@onready var health_bar = $HealthBar
var health = 0.0

func _ready(): 
	#health_bar = $StaticBody3D/HealthBar
	pass
	
func _process(delta):
	health_bar.health = health
	pass

func health_bar_invisible(): 
	health_bar.visible = false

func select():
	if not is_in_group("Selectable"): 
		return
	$SelectionRing.visible = true 
	
func deselect(): 
	if not is_in_group("Selectable"): 
		return
	$SelectionRing.visible = false

# Annoying to have to rewrite some code from unit, I would've looked into a better approach with more time 
signal death
func damage(d):
	if not is_in_group("Damageable"): return 
	
	health -= d
	print(health)
	if health <= 0: 
		print(death)
		await emit_signal("death", self)
		queue_free()
