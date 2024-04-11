extends Node3D
class_name Building

var health_bar : Node3D
var health = 0.0


func _ready(): 
	health_bar = $StaticBody3D/HealthBar
	
func _process(delta):
	#health_bar.health = health
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
	health -= d
	if health <= 0: 
		await emit_signal("death", self)
		queue_free()
