extends Node

# Track the score and number of attempts
var buildings_ui = true
var money = 12500.0

var power_total = 50.0
var power_owned = 0.0
var power_used = 10.0

# Constant amount of time to wait for a building to build, can be changed to individual if necessary
var building_wait_time = 2.0 
 
# Track the count, power usage, and cost of buildings 
var headquarters_cost = 2500
var headquarters_power = 10
var headquarters = false
var headquarters_waiting = false

var refinery_cost = 200
var refinery_power = -3
var num_refineries = 0
var max_refineries = 0 
var refineries_waiting = false

var barracks_cost = 200 
var barracks_power = -3 
var num_barracks = 0 
var max_barracks = 0 
var barracks_waiting = false 

var power_plant_cost = 300 
var power_plant_power = 10 
var num_power_plants = 0
var max_power_plants = 0 
var power_plants_waiting = false 

var factory_cost = 200 
var factory_power = -3
var num_factories = 0  
var max_factories = 0 
var factories_waiting = false 

var airport_cost = 200 
var airport_power = -3
var num_airports = 0 
var max_airports = 0 
var airports_waiting = false 

var turret_cost = 200 
var turret_power = -25
var num_turrets = 0  
var max_turrets = 0 
var turrets_waiting = false 

var nuclear_plant_cost = 200 
var nuclear_plant_power = -14
var nuclear_plant = false 
var nuclear_plant_waiting = false 




	
	

