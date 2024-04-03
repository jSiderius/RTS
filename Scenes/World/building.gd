extends Node3D

@onready var health_bar = $HealthBar
var health = 0


func _process(delta):
	health_bar.health = health

func health_bar_invisible(): 
	health_bar.visible = false

var truck = preload("res://Scenes/Units/FriendlyUnits/resource_truck.tscn")
func instantiate_truck(): 
	if is_in_group("Refinery"):
		var instance = truck.instantiate()
		var transf = instance.global_transform
		
		transf = transf.scaled(Vector3(2.0, 2.0, 2.0))
		transf = transf.rotated(Vector3(0.0, 1.0, 0.0), -1.57079)
		transf = transf.translated(Vector3(-18.395, -2.5, 0.0))
		#transf.origin += 
		instance.global_transform = transf
		add_child(instance)

func select():
	if not is_in_group("Selectable"): 
		return
	$SelectionRing.visible = true 
	
func deselect(): 
	if not is_in_group("Selectable"): 
		return
	$SelectionRing.visible = false
