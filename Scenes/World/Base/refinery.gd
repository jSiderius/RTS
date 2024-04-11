extends Building

var truck = preload("res://Scenes/Units/FriendlyUnits/resource_truck.tscn")
func instantiate_truck(): 
	#print()
	if is_in_group("Refinery"):
		var instance = truck.instantiate()
		var transf = instance.global_transform
		
		transf = transf.scaled(Vector3(0.6, 0.6, 0.6))
		transf = transf.rotated(Vector3(0.0, 1.0, 0.0), -1.57079)
		transf = transf.translated(Vector3(-18.395, -0.25, 2.0))
		#transf.origin += 
		instance.global_transform = transf
		instance.death.connect(_on_truck_death)
		add_child(instance)

signal truck_death	
func _on_truck_death(unit): 
	#selected_units.erase(unit)
	await emit_signal("truck_death")
	unit.queue_free()
	
	await get_tree().create_timer(1).timeout
	instantiate_truck()
	

	
