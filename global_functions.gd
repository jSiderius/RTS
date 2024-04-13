extends Node

# Global function to determine if a node is in one of several groups
func is_in_groups(node : Node, groups : Array): 
	if node == null: return false
	for group in groups: 
		if node.is_in_group(group): 
			return true
	return false

#NOTE: When waiting, a button will disable itself
#NOTE: When requirements of building not met, building will also be disabled
#NOTE: num_building against max_building requirement is checked in game.gd
#NOTE: Therefore we don't check for these here 

# Function to handle logic when buying the headquarters
func buy_headquarters(node): 
	if GlobalData.headquarters:
		popup("Headquarters Already Exist")
		return false
	GlobalData.money -= GlobalData.headquarters_cost
	GlobalData.headquarters_waiting = true
	
	node.visible = true
	set_transparancy_multiple_meshes(node, 0.6)
	
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_transparancy_multiple_meshes(node, 1.0)
	GlobalData.headquarters = true
	GlobalData.power_owned += GlobalData.headquarters_power
	GlobalData.headquarters_waiting = false 
	return true 

# Function to handle logic when buying the refinery
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
	set_transparancy_multiple_meshes(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_transparancy_multiple_meshes(node, 1.0)
	node.instantiate_truck()
	node.health_bar_invisible()
	GlobalData.num_refineries += 1
	GlobalData.refineries_waiting = false 
	return true
	
# Function to handle logic when buying the power plant
func buy_power_plant(node): 
	if GlobalData.money < GlobalData.power_plant_cost:
		popup("insufficient money, harvest resources")
		return false
	GlobalData.money -= GlobalData.power_plant_cost
	GlobalData.power_plants_waiting = true 
	
	node.visible = true
	set_transparancy_multiple_meshes(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	node.health_bar_invisible()
	set_transparancy_multiple_meshes(node, 1.0)
	GlobalData.power_owned += GlobalData.power_plant_power
	GlobalData.num_power_plants += 1
	GlobalData.power_plants_waiting = false 
	return true

# Function to handle logic when buying the barracks
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
	set_transparancy_multiple_meshes(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_transparancy_multiple_meshes(node, 1.0)
	node.health_bar_invisible()
	GlobalData.num_barracks += 1
	GlobalData.barracks_waiting = false
	return true

# Function to handle logic when buying the factory
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
	GlobalData.factories_waiting = true
	set_transparancy_multiple_meshes(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_transparancy_multiple_meshes(node, 1.0)
	node.health_bar_invisible()
	GlobalData.num_factories += 1
	GlobalData.factories_waiting = false 
	return true

func buy_turret(node): 
	if GlobalData.money < GlobalData.turret_cost:
		popup("insufficient money, harvest resources")
		return false
	GlobalData.money -= GlobalData.turret_cost
	GlobalData.turrets_waiting = true 
	GlobalData.power_used -= GlobalData.turret_power
	
	node.visible = true
	for i in range(node.get_child_count()):
			node.get_child(i).visible = true
			
	set_transparancy_multiple_meshes(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		for j in range(node.get_child_count()):
			node.get_child(j).health += 10
	
	GlobalData.num_turrets += 1
	GlobalData.turrets_waiting = false 	
	set_transparancy_multiple_meshes(node, 1.0)
	for i in range(node.get_child_count()):
			node.get_child(i).set_ready()

	
	
# Function to handle logic when buying the airport
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
	set_transparancy_multiple_meshes(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_transparancy_multiple_meshes(node, 1.0)
	node.health_bar_invisible()
	GlobalData.num_airports += 1
	GlobalData.airports_waiting = false 
	return true

# Function to handle logic when buying the nuclear plant
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
	set_transparancy_multiple_meshes(node, 0.6)
	for i in range(10): 
		await get_tree().create_timer(GlobalData.building_wait_time / 10).timeout
		node.health += 10
	set_transparancy_multiple_meshes(node, 1.0)
	node.health_bar_invisible()
	GlobalData.nuclear_plant = true
	GlobalData.nuclear_plant_waiting = false 
	nuke_popup()
	return true 

var popup_scene = preload("res://Scenes/UI/PopupUI/popup.tscn")
func popup(text):
	var instance = popup_scene.instantiate()
	add_child(instance)
	instance.find_child("Text").text = text
	await get_tree().create_timer(GlobalData.popup_wait_time).timeout
	instance.queue_free()

var n_popup = preload("res://Scenes/UI/PopupUI/nuke_popup.tscn")
func nuke_popup(): 
	var instance = n_popup.instantiate()
	get_tree().get_root().add_child(instance)

# Function to set transparancy for a MeshInstance3D
func set_node_transparancy(node, a): 
	# Iterate every material in the mesh 
	for i in range(node.get_surface_override_material_count()):
		var surface = node.get_active_material(i)
		
		# Make sure the material exists and is compatible with transparency
		if surface:
			# Materials usually need to be duplicated 
			surface = surface.duplicate() 
			var col = surface.albedo_color
			if a == 1.0: 
				surface.transparency = 0
			else:
				surface.transparency = 1
			surface.albedo_color = Color(col.r, col.g, col.b, a)
			node.set_surface_override_material(i, surface)

# Recursively call set_node_transparancy() for multiple MeshInstance3D
func set_transparancy_multiple_meshes(node, a):
	# Iterate through each child node of the given node
	for i in range(node.get_child_count()):
		var child_node = node.get_child(i)
		
		# Check if the child node is a MeshInstance3D
		if child_node is MeshInstance3D:
			set_node_transparancy(child_node, a)
	
		# Recursively call this function on child nodes
		set_transparancy_multiple_meshes(child_node, a)
