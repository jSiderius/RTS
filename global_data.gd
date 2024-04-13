extends Node

# Track the score and number of attempts
#var buildings_ui = true
var money = 125000.0 #eventually should be $2800

var power_total = 50.0
var power_owned = 0.0
var power_used = 0.0

# Constant amount of time to wait for a building to build, can be changed to individual if necessary
var building_wait_time = 5.0
var popup_wait_time = 2.0

var box_value = 100 # Boxes will probably have different values so this can be a get from the collided object 
 
# Track the count, power usage, and cost of buildings 
var headquarters_cost = 2500
var headquarters_power = 10
var headquarters = false
var headquarters_waiting = null

var refinery_cost = 300
var refinery_power = -2
var num_refineries = 0
var max_refineries = 0 
var refineries_waiting = null

var barracks_cost = 400 
var barracks_power = -2 
var num_barracks = 0 
var max_barracks = 0 
var barracks_waiting = null 

var power_plant_cost = 800 
var power_plant_power = 10 
var num_power_plants = 0
var max_power_plants = 0 
var power_plants_waiting = null 

var factory_cost = 800 
var factory_power = -5
var num_factories = 0  
var max_factories = 0 
var factories_waiting = null 

var airport_cost = 1600 
var airport_power = -5
var num_airports = 0 
var max_airports = 0 
var airports_waiting = null 

var turret_cost = 800
var turret_power = 0 
var num_turrets = 0
var max_turrets = 0 
var turrets_waiting = null

var nuclear_plant_cost = 4500
var nuclear_plant_power = -14
var nuclear_plant = false 
var nuclear_plant_waiting = null 

#Same for Units
var general_infantry_cost = 50 
var rocket_infantry_cost = 80 
var tank_cost = 400 
var armoured_car_cost = 300 
var mg_chopper_cost = 600 
