extends Node3D

@onready var buildings_ui = $BuildingsUI
@onready var units_ui = $UnitsUI
@onready var headquarters = $NavRegionMain/SimpleTerrain/Base/Headquarters
@onready var quarters : Array = [$NavRegionMain/SimpleTerrain/Base/Quarters/Quarter1, $NavRegionMain/SimpleTerrain/Base/Quarters/Quarter2, $NavRegionMain/SimpleTerrain/Base/Quarters/Quarter3, $NavRegionMain/SimpleTerrain/Base/Quarters/Quarter4] 
@onready var refineries : Array = [$NavRegionMain/SimpleTerrain/Base/Refineries/Refinery1, $NavRegionMain/SimpleTerrain/Base/Refineries/Refinery2, $NavRegionMain/SimpleTerrain/Base/Refineries/Refinery3, $NavRegionMain/SimpleTerrain/Base/Refineries/Refinery4] 
@onready var factories : Array = [$NavRegionMain/SimpleTerrain/Base/Factories/Factory1, $NavRegionMain/SimpleTerrain/Base/Factories/Factory2]
@onready var airports : Array = [$NavRegionMain/SimpleTerrain/Base/Airports/Airport1, $NavRegionMain/SimpleTerrain/Base/Airports/Airport2]
@onready var nuclear_plant = $NavRegionMain/SimpleTerrain/Base/NuclearPlant
@onready var power_plants = [$NavRegionMain/SimpleTerrain/Base/PowerPlants/PowerPlant1, $NavRegionMain/SimpleTerrain/Base/PowerPlants/PowerPlant2, $NavRegionMain/SimpleTerrain/Base/PowerPlants/PowerPlant3, $NavRegionMain/SimpleTerrain/Base/PowerPlants/PowerPlant4]
@onready var towers = $NavRegionMain/SimpleTerrain/Base/Towers

var headquarters_start_time = null
var quarters_start_time = null
var refinery_start_time = null
var factory_start_time = null
var airport_start_time = null
var nuclear_plant_start_time = null
var power_plant_start_time = null

var num_headquarters = false
var num_quarters = 0
var num_refineries = 0
var num_factories = 0 
var num_airports = 0 
var num_nuclear_plant = false
var num_power_plants = 0

func _ready():
	_init_signals()
	_init_visibility()

func _init_signals(): 
	buildings_ui.headquarters_pressed.connect(_on_headquarters_pressed)
	buildings_ui.quarters_pressed.connect(_on_quarters_pressed)
	buildings_ui.refinery_pressed.connect(_on_refinery_pressed)
	buildings_ui.factory_pressed.connect(_on_factory_pressed)
	buildings_ui.airport_pressed.connect(_on_airport_pressed)
	buildings_ui.nuclear_plant_pressed.connect(_on_nuclear_plant_pressed)
	buildings_ui.power_plant_pressed.connect(_on_power_plant_pressed) 
	
func _init_visibility(): 
	headquarters.visible = false
	nuclear_plant.visible = false
	towers.visible = false
	for quarter in quarters: 
		quarter.visible = false 
	for refinery in refineries: 
		refinery.visible = false
	for factory in factories: 
		factory.visible = false
	for airport in airports: 
		airport.visible = false 
	for power_plant in power_plants: 
		power_plant.visible = false 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GlobalData.getBuildingsUI()):
		buildings_ui.visible = true
		units_ui.visible = false
	else: 
		buildings_ui.visible = false
		units_ui.visible = true
	#GlobalData.setMoney(GlobalData.getMoney() + 10.0 * delta)

func _on_headquarters_pressed():
	num_headquarters = true 
	headquarters.visible = true 
	#headquarters.modulate.a = 0.5
func _on_quarters_pressed():
	if num_quarters >= quarters.size(): 
		return  
	quarters[num_quarters].visible = true 
	num_quarters += 1
func _on_refinery_pressed():
	if num_refineries >= refineries.size(): 
		return  
	refineries[num_refineries].visible = true 
	num_refineries += 1
func _on_factory_pressed(): 
	if num_factories >= factories.size(): 
		return
	factories[num_factories].visible = true
	num_factories += 1
func _on_airport_pressed():
	if num_airports >= airports.size(): 
		return  
	airports[num_airports].visible = true 
	num_airports += 1
func _on_nuclear_plant_pressed():
	num_nuclear_plant = true 
	nuclear_plant.visible = true 
func _on_power_plant_pressed(): 
	if num_power_plants >= power_plants.size(): 
		return  
	power_plants[num_power_plants].visible = true 
	num_power_plants += 1
