extends Node

# Global function to determine if a node is in one of several groups
func is_in_groups(node : Node, groups : Array[String]): 
	for group in groups: 
		if node.is_in_group(group): 
			return true
	return false

func buy_headquarters(node): 
	if GlobalData.headquarters or GlobalData.headquarters_waiting: # headquarters is always the first buy so no reason for other logic checks 
		return false
	GlobalData.money -= GlobalData.headquarters_cost
	GlobalData.headquarters_waiting = true
	#GlobalData.power_total += GlobalData.headquarters_cost have to figure this out
	
	#node.modulate.a = 0.5 #FOR BUILD TIME 
	#node.get_surface_overide_material(0)
	#node.get_active_material(0).a = 0.0
	
	
	
	await get_tree().create_timer(GlobalData.building_wait_time).timeout
	node.visible = true
	GlobalData.headquarters = true
	GlobalData.power_owned += GlobalData.headquarters_power
	GlobalData.headquarters_waiting = false 
	return true 

func buy_refinery(node): 
	if 	GlobalData.num_refineries >= GlobalData.max_refineries \
		or GlobalData.money < GlobalData.refinery_cost \
		or GlobalData.refineries_waiting \
		or not GlobalData.headquarters: 
		return false
	GlobalData.money -= GlobalData.refinery_cost
	GlobalData.power_used -= GlobalData.refinery_cost
	GlobalData.refineries_waiting = true 
	await get_tree().create_timer(GlobalData.building_wait_time).timeout
	GlobalData.num_refineries += 1
	node.visible = true
	GlobalData.refineries_waiting = false 
	return true
	
func buy_power_plant(node): 
	if 	GlobalData.num_power_plants >= GlobalData.max_power_plants \
		or GlobalData.money < GlobalData.power_plant_cost \
		or GlobalData.power_plants_waiting \
		or not GlobalData.headquarters: 
		return false
	GlobalData.money -= GlobalData.power_plant_cost
	GlobalData.power_plants_waiting = true 
	await get_tree().create_timer(GlobalData.building_wait_time).timeout
	GlobalData.power_owned += GlobalData.power_plant_power
	GlobalData.num_power_plants += 1
	node.visible = true
	GlobalData.power_plants_waiting = false 
	return true
	
func buy_barracks(node): 
	if 	GlobalData.num_barracks >= GlobalData.max_barracks \
		or GlobalData.money < GlobalData.barracks_cost \
		or GlobalData.barracks_waiting \
		or GlobalData.num_refineries == 0 or GlobalData.num_power_plants == 0: 
		return false
	GlobalData.money -= GlobalData.barracks_cost
	GlobalData.power_used -= GlobalData.barracks_power
	GlobalData.barracks_waiting = true 
	await get_tree().create_timer(GlobalData.building_wait_time).timeout
	GlobalData.num_barracks += 1
	node.visible = true
	GlobalData.barracks_waiting = false
	return true

func buy_factory(node): 
	if GlobalData.num_factories >= GlobalData.max_factories \
	or GlobalData.money < GlobalData.factory_cost \
	or GlobalData.factories_waiting \
	or GlobalData.num_barracks == 0: 
		return false
	GlobalData.money -= GlobalData.factory_cost
	GlobalData.power_used -= GlobalData.factory_power
	GlobalData.factories_waiting
	await get_tree().create_timer(GlobalData.building_wait_time).timeout
	GlobalData.num_factories += 1
	node.visible = true
	GlobalData.factories_waiting = false 
	return true

func buy_airport(node): 
	if 	GlobalData.num_airports >= GlobalData.max_airports \
		or GlobalData.money < GlobalData.airport_cost \
		or GlobalData.airports_waiting \
		or GlobalData.num_factories == 0: 
		return false
	GlobalData.money -= GlobalData.airport_cost
	GlobalData.airports_waiting = true 
	GlobalData.power_used -= GlobalData.airport_power
	await get_tree().create_timer(GlobalData.building_wait_time).timeout
	GlobalData.num_airports += 1
	node.visible = true
	GlobalData.airports_waiting = false 
	return true

func buy_turret(node): 
	pass

func buy_nuclear_plant(node): 
	if GlobalData.nuclear_plant \
	or GlobalData.money < GlobalData.nuclear_plant_cost \
	or GlobalData.nuclear_plant_waiting \
	or GlobalData.num_airports == 0:
		return false
	GlobalData.money -= GlobalData.nuclear_plant_cost
	GlobalData.nuclear_plant_waiting = true 
	GlobalData.power_used -= GlobalData.nuclear_plant_power
	await get_tree().create_timer(GlobalData.building_wait_time).timeout
	node.visible = true
	GlobalData.nuclear_plant = true
	GlobalData.nuclear_plant_waiting = false 
	return true 

func update_wait_times(): 
	pass
