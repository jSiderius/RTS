extends Node

# Global function to determine if a node is in one of several groups
func is_in_groups(node : Node, groups : Array[String]): 
	for group in groups: 
		if node.is_in_group(group): 
			return true
	return false

#NOTE: When waiting, a button will disable itself
#NOTE: When requirements of building not met, building will also be disabled
#NOTE: num_building against max_building requirement is checked in game.gd
#NOTE: Therefore we don't check for these here 
func buy_headquarters(node): 
	if GlobalData.headquarters:
		popup("Headquarters Already Exist")
		return false
	GlobalData.money -= GlobalData.headquarters_cost
	GlobalData.headquarters_waiting = true
	GlobalData.headquarters = true
	
	node.visible = true
	set_node_transparancy(node, 0.6)
	
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_node_transparancy(node, 1.0)
	GlobalData.headquarters = true
	GlobalData.power_owned += GlobalData.headquarters_power
	GlobalData.headquarters_waiting = false 
	return true 

func buy_refinery(node): 
	if GlobalData.money < GlobalData.refinery_cost:
		popup("insufficient money, harvest resources")
		return false
	if GlobalData.power_owned < GlobalData.power_used + abs(GlobalData.refinery_power): 
		popup("insufficient power, purchase additional power plants")
		return false
	GlobalData.money -= GlobalData.refinery_cost
	GlobalData.power_used -= GlobalData.refinery_power 
	GlobalData.refineries_waiting = true 
	
	node.visible = true
	set_node_transparancy(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_node_transparancy(node, 1.0)
	node.health_bar_invisible()
	GlobalData.num_refineries += 1
	GlobalData.refineries_waiting = false 
	return true
	
func buy_power_plant(node): 
	if GlobalData.money < GlobalData.power_plant_cost:
		popup("insufficient money, harvest resources")
		return false
	GlobalData.money -= GlobalData.power_plant_cost
	GlobalData.power_plants_waiting = true 
	
	node.visible = true
	#set_node_transparancy(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	node.health_bar_invisible()
	#set_node_transparancy(node, 1.0)
	GlobalData.power_owned += GlobalData.power_plant_power
	GlobalData.num_power_plants += 1
	GlobalData.power_plants_waiting = false 
	return true
	
func buy_barracks(node): 
	if GlobalData.money < GlobalData.barracks_cost: 
		popup("insufficient money, harvest resources")
		return false
	if GlobalData.power_owned < GlobalData.power_used + abs(GlobalData.barracks_power):
		popup("insufficient power, purchase additional power plants")
		return false
	GlobalData.money -= GlobalData.barracks_cost
	GlobalData.power_used -= GlobalData.barracks_power
	GlobalData.barracks_waiting = true 
	
	node.visible = true
	set_node_transparancy(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_node_transparancy(node, 1.0)
	node.health_bar_invisible()
	GlobalData.num_barracks += 1
	GlobalData.barracks_waiting = false
	return true

func buy_factory(node): 
	if GlobalData.money < GlobalData.factory_cost:
		popup("insufficient money, harvest resources")
		return false
	if GlobalData.power_owned < GlobalData.power_used + abs(GlobalData.factory_power):
		popup("insufficient power, purchase additional power plants")
		return false
		
	GlobalData.money -= GlobalData.factory_cost
	GlobalData.power_used -= GlobalData.factory_power
	GlobalData.factories_waiting
	
	node.visible = true
	set_node_transparancy(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_node_transparancy(node, 1.0)
	node.health_bar_invisible()
	GlobalData.num_factories += 1
	GlobalData.factories_waiting = false 
	return true

func buy_airport(node): 
	if GlobalData.money < GlobalData.airport_cost:
		popup("insufficient money, harvest resources")
		return false
	if GlobalData.power_owned < GlobalData.power_used + abs(GlobalData.airport_power):
		popup("insufficient power, purchase additional power plants")
		return false
	GlobalData.money -= GlobalData.airport_cost
	GlobalData.airports_waiting = true 
	GlobalData.power_used -= GlobalData.airport_power
	
	node.visible = true
	set_node_transparancy(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_node_transparancy(node, 1.0)
	node.health_bar_invisible()
	GlobalData.num_airports += 1
	GlobalData.airports_waiting = false 
	return true

func buy_nuclear_plant(node): 
	if GlobalData.nuclear_plant: 
		popup("Nuclear plant already purchased")
		return false
	if GlobalData.money < GlobalData.nuclear_plant_cost:
		popup("insufficient money, harvest resources")
		return false
	if GlobalData.power_owned < GlobalData.power_used + abs(GlobalData.nuclear_plant_power):
		popup("insufficient power, purchase additional power plants")
		return false

	GlobalData.money -= GlobalData.nuclear_plant_cost
	GlobalData.nuclear_plant_waiting = true 
	GlobalData.power_used -= GlobalData.nuclear_plant_power
	
	node.visible = true
	#set_node_transparancy(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	#set_node_transparancy(node, 1.0)
	node.health_bar_invisible()
	GlobalData.nuclear_plant = true
	GlobalData.nuclear_plant_waiting = false 
	return true 

func buy_turret(node): 
	pass

var popup_scene = preload("res://Scenes/UI/popup.tscn")
func popup(text):
	var instance = popup_scene.instantiate()
	add_child(instance)
	instance.find_child("Text").text = text
	await get_tree().create_timer(GlobalData.popup_wait_time).timeout
	instance.queue_free()

func set_node_transparancy(node, a): 
	for i in range(7):
		#var surface = node.get_surface_override_material(i)
		var surface = node.get_active_material(i)
		# Make sure the material exists and is compatible with transparency
		if surface:
			print_debug(i)
			surface = surface.duplicate() 
			var col = surface.albedo_color
			if a == 1.0: 
				surface.transparency = 0
			else:
				surface.transparency = 1
			surface.albedo_color = Color(col.r, col.g, col.b, a)
			node.set_surface_override_material(i, surface)
