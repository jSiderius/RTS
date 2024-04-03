extends Node3D


const RAY_LENGTH = 2000

var selected_units = []
var select_pos = Vector2()
@onready var selection_box = $SelectionBox
@onready var cam = $CameraBase/Camera3D

func _ready():
	_init_signals()
	_init_visibility()
	_init_global_data()

func _process(delta):
	# Updates which UI is displayed
	if(GlobalData.buildings_ui):
		buildings_ui.visible = true
		units_ui.visible = false
	else: 
		buildings_ui.visible = false
		units_ui.visible = true
		
	# Get the current mouse position
	var m_pos = get_viewport().get_mouse_position()
	
	# Handle target selection
	if Input.is_action_just_pressed("main_command"):
		move_selected_units(m_pos)
		var unit = get_unit_under_mouse(m_pos, ["EnemyUnit", "EnemyBuilding", "Collectable"])
		clear_targets()
		if unit and (unit.is_in_group("EnemyUnit") or unit.is_in_group("EnemyBuilding")): 
			target_enemy_unit(unit)
		if unit and unit.is_in_group("ResourceCollectable"):
			target_resource_collectable(unit)
		if unit and unit.is_in_group("HealthCollectable"):
			target_health_collectable(unit)
		if unit and unit.is_in_group("WeaponUpgradeCollectable"):
			target_weapon_upgrade(unit)
	
	# On LMB just pressed, save the mouse information
	if Input.is_action_just_pressed("alt_command"):
		selection_box.select_pos = m_pos
		select_pos = m_pos
	
	# While LMB is pressed inform the selection box so it can render correctly
	if Input.is_action_pressed("alt_command"):
		selection_box.m_pos = m_pos
		selection_box.visible = true
	else: 
		selection_box.visible = false
		
	# Handle unit selection on LMB released
	if Input.is_action_just_released("alt_command"):
		select_units(m_pos)

func move_selected_units(m_pos):
	#var collision_mask = 1 << 2 #| 1 << layer2 | ... | 1 << layer <--- Sample, A way to set up collision masks
	var result = raycast_from_mouse(m_pos, 1) # Check for on object at a ray cast from the mouse 
	# Return if theres none 
	if not result:
		return 
	# Update the units targets 
	for unit in selected_units: 
		unit.update_target_location(result.position)
	
func select_units(m_pos):
	var new_selected_units = []
	# If the mouse position is close to the select position (initial click) then use the click functionality
	if m_pos.distance_to(select_pos) < 30: 
		var unit = get_unit_under_mouse(m_pos, ["Unit"])
		if unit:
			new_selected_units.append(unit)
	# If its far use the drag select functionality 
	else: 
		new_selected_units = get_units_in_box(select_pos, m_pos)
	# Deselect all previously selected units
	for unit in selected_units: 
		unit.deselect()
	# Select all new units
	for unit in new_selected_units: 
		unit.select()
	selected_units = new_selected_units
	
# Returns any unit directly underneath the mouse and in the provided groups
func get_unit_under_mouse(m_pos, groups : Array[String]): 
	var result = raycast_from_mouse(m_pos, 0x5) # Raycast from the mouse (collision mask 1 & 3)
	# Check if the result exists and is a relevant node 
	if result and GlobalFunctions.is_in_groups(result.collider, groups): 
		return result.collider 

# Get the units under a drag and drop box
func get_units_in_box(top_left, bot_right): 
	# Switch top_left and bot_right to actually be the top left and bottom right if they are not
	if top_left.x > bot_right.x: 
		var temp = top_left.x
		top_left.x = bot_right.x
		bot_right.x = temp
	if top_left.y > bot_right.y: 
		var temp = top_left.y
		top_left.y = bot_right.y
		bot_right.y = temp
	var box = Rect2(top_left, bot_right - top_left)
	var box_selected_units = [] 
	# Get all units and check if they are in the constraints of the box 
	for unit in get_tree().get_nodes_in_group("Unit"):
		if box.has_point(cam.unproject_position(unit.global_transform.origin)): 
			box_selected_units.append(unit)
	return box_selected_units
	
# Project a ray from the mouse to the closest object in the collision mask
func raycast_from_mouse(m_pos, collision_mask):
	var ray_start = cam.global_transform.origin 
	var ray_end = ray_start + cam.project_ray_normal(m_pos) * RAY_LENGTH
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_start
	params.to = ray_end
	params.exclude = []
	params.collision_mask = collision_mask 
	
	return space_state.intersect_ray(params)

# Set an enemy as a target for all selected units who can target is 
func target_enemy_unit(enemy): 
	for unit in selected_units: 
		if unit.is_in_group("AttackingUnit"):
			unit.set_target(enemy) 

# Set a resource collectable as a target for all selected units who can target is 
func target_resource_collectable(resource): 
	for unit in selected_units: 
		if unit.is_in_group("ResourceUnit"):
			unit.set_target(resource) 

# Set a health collectable as a target for all selected units who can target is 
func target_health_collectable(health):
	for unit in selected_units: 
		if unit.is_in_group("HealableUnit"):
			unit.set_target(health) 

# Set a weapon collectable as a target for all selected units who can target is 
func target_weapon_upgrade(weapon):
	for unit in selected_units: 
		if unit.is_in_group("WeaponUpgradeUnit"):
			unit.set_target(weapon) 

# Clear targets for all selected units
func clear_targets(): 
	for unit in selected_units: 
		unit.clear_target() 


# ------------------------------------------------------------ HANDLES BASE BUILDING ------------------------------------------------------------
@onready var buildings_ui = $BuildingsUI
@onready var units_ui = $UnitsUI
@onready var nav_region = $NavRegionMain
@onready var headquarters = $NavRegionMain/SimpleTerrain/Base/Headquarters
@onready var barracks : Array = [$NavRegionMain/SimpleTerrain/Base/Quarters/Quarter1, $NavRegionMain/SimpleTerrain/Base/Quarters/Quarter2, $NavRegionMain/SimpleTerrain/Base/Quarters/Quarter3, $NavRegionMain/SimpleTerrain/Base/Quarters/Quarter4] 
@onready var refineries : Array = [$NavRegionMain/SimpleTerrain/Base/Refineries/Refinery1, $NavRegionMain/SimpleTerrain/Base/Refineries/Refinery2, $NavRegionMain/SimpleTerrain/Base/Refineries/Refinery3, $NavRegionMain/SimpleTerrain/Base/Refineries/Refinery4] 
@onready var factories : Array = [$NavRegionMain/SimpleTerrain/Base/Factories/Factory1, $NavRegionMain/SimpleTerrain/Base/Factories/Factory2]
@onready var airports : Array = [$NavRegionMain/SimpleTerrain/Base/Airports/Airport1, $NavRegionMain/SimpleTerrain/Base/Airports/Airport2]
@onready var nuclear_plant = $NavRegionMain/SimpleTerrain/Base/NuclearPlant
@onready var power_plants = [$NavRegionMain/SimpleTerrain/Base/PowerPlants/PowerPlant1, $NavRegionMain/SimpleTerrain/Base/PowerPlants/PowerPlant2, $NavRegionMain/SimpleTerrain/Base/PowerPlants/PowerPlant3, $NavRegionMain/SimpleTerrain/Base/PowerPlants/PowerPlant4]
@onready var towers = $NavRegionMain/SimpleTerrain/Base/Towers

func _init_signals(): 
	# IDEALLY CAN CONNECT THESE DIRECTLY TO GLOBAL FUNCTIONS WITH AN ARGUMENT 
	buildings_ui.headquarters_pressed.connect(_on_headquarters_pressed)
	buildings_ui.barracks_pressed.connect(_on_barracks_pressed)
	buildings_ui.refinery_pressed.connect(_on_refinery_pressed)
	buildings_ui.factory_pressed.connect(_on_factory_pressed)
	buildings_ui.airport_pressed.connect(_on_airport_pressed)
	buildings_ui.nuclear_plant_pressed.connect(_on_nuclear_plant_pressed)
	buildings_ui.power_plant_pressed.connect(_on_power_plant_pressed)
	units_ui.general_infantry_pressed.connect(_on_general_infantry_pressed)
	units_ui.rocket_infantry_pressed.connect(_on_rocket_infantry_pressed)
	units_ui.tank_pressed.connect(_on_tank_pressed)
	units_ui.armoured_car_pressed.connect(_on_armoured_car_pressed)
	units_ui.mg_helicopter_pressed.connect(_on_mg_helicopter_pressed)
	units_ui.rocket_helicopter_pressed.connect(_on_rocket_helicopter_pressed)
		
func _init_visibility(): 
	headquarters.visible = false
	nuclear_plant.visible = false
	towers.visible = false
	for barrack in barracks: 
		barrack.visible = false 
	for refinery in refineries: 
		refinery.visible = false
	for factory in factories: 
		factory.visible = false
	for airport in airports: 
		airport.visible = false 
	for power_plant in power_plants: 
		power_plant.visible = false 

func _init_global_data(): 
	GlobalData.max_barracks = barracks.size()
	GlobalData.max_refineries = refineries.size()
	GlobalData.max_factories = factories.size()
	GlobalData.max_airports = airports.size()
	GlobalData.max_power_plants = power_plants.size()
	
func _on_headquarters_pressed():
	GlobalFunctions.buy_headquarters(headquarters) 
	
func _on_barracks_pressed():
	if GlobalData.num_barracks >= GlobalData.max_barracks: 
		GlobalFunctions.popup("Maximum barracks purchased")
		return
	GlobalFunctions.buy_barracks(barracks[GlobalData.num_barracks])
	
func _on_refinery_pressed():
	if GlobalData.num_refineries >= GlobalData.max_refineries: 
		GlobalFunctions.popup("Maximum refineries purchased")
		return 
	GlobalFunctions.buy_refinery(refineries[GlobalData.num_refineries])
	
func _on_factory_pressed(): 
	if GlobalData.num_factories >= GlobalData.max_factories: 
		GlobalFunctions.popup("Maximum factories purchased")
		return
	GlobalFunctions.buy_factory(factories[GlobalData.num_factories])
	
func _on_airport_pressed():
	if GlobalData.num_airports >= GlobalData.max_airports: 
		GlobalFunctions.popup("Maximum airports purchased")
		return
	GlobalFunctions.buy_airport(airports[GlobalData.num_airports])
	
func _on_nuclear_plant_pressed():
	GlobalFunctions.buy_nuclear_plant(nuclear_plant)
		
func _on_power_plant_pressed(): 
	if GlobalData.num_power_plants >= GlobalData.max_power_plants: 
		GlobalFunctions.popup("Maximum power plants purchased")
		return
	GlobalFunctions.buy_power_plant(power_plants[GlobalData.num_power_plants])

func _update_building_visiblility(): 
	pass

var general_infantry = preload("res://Scenes/Units/FriendlyUnits/general_infantry.tscn")
func _on_general_infantry_pressed(): 
	var instance = general_infantry.instantiate()
	var transf = instance.global_transform 
	transf = transf.scaled(Vector3(4, 4, 4))
	transf = transf.rotated(Vector3(0.0, 1.0, 0.0), -1.57079)
	transf.origin = Vector3(-80, 5, -30)
	
	instance.global_transform = transf  
	nav_region.add_child(instance)
	instance.update_target_location(Vector3(-180, 0, -65))
	
var rocket_infantry = preload("res://Scenes/Units/FriendlyUnits/rocket_infantry.tscn")
func _on_rocket_infantry_pressed(): 
	var instance = rocket_infantry.instantiate()
	var transf = instance.global_transform 
	transf = transf.scaled(Vector3(4, 4, 4))
	transf = transf.rotated(Vector3(0.0, 1.0, 0.0), -1.57079)
	transf.origin = Vector3(-80, 5, -64)
	
	instance.global_transform = transf  
	nav_region.add_child(instance)
	instance.update_target_location(Vector3(-180, 5, -125))
	
var tank = preload("res://Scenes/Units/FriendlyUnits/tank.tscn")
func _on_tank_pressed(): 
	var instance = tank.instantiate()
	var transf = instance.global_transform 
	transf = transf.scaled(Vector3(3.2, 3.2, 3.2))
	transf = transf.rotated(Vector3(0.0, 1.0, 0.0), -1.57079)
	transf.origin = Vector3(71.0, 5, -3.0)
	
	instance.global_transform = transf  
	nav_region.add_child(instance)
	instance.update_target_location(Vector3(145, 5, -0))

var ac = preload("res://Scenes/Units/FriendlyUnits/armoured_car.tscn")
func _on_armoured_car_pressed(): 
	var instance = ac.instantiate()
	var transf = instance.global_transform 
	transf = transf.scaled(Vector3(3.2, 3.2, 3.2))
	transf = transf.rotated(Vector3(0.0, 1.0, 0.0), -1.57079)
	transf.origin = Vector3(71.0, 5, -3.0)
	
	instance.global_transform = transf  
	nav_region.add_child(instance)
	instance.update_target_location(Vector3(145, 5, -0))
	
func _on_mg_helicopter_pressed(): 
	print("MGH")
	
func _on_rocket_helicopter_pressed(): 
	print("RH")
	
