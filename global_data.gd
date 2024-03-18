extends Node

# Track the score and number of attempts
var buildings_ui = true
var money = 0.0

var power_total = 100.0
var power_owned = 70.0
var power_used = 30.0
 
var headquarters_cost = 2500
var headquarters_power = 100
var headquarters = false
var refinery_cost = 200
var refinery_power = -25
var num_refineries = 0
var barracks_cost = 200 
var barracks_power = -25 
var num_barracks = 0 
var power_plant_cost = 300 
var power_plant_power = 200 
var num_power_plants = 0
var factory_cost = 200 
var factory_power = -25
var rnum_factories = 0  
var airport_cost = 200 
var airport_power = -25 
var num_airports = 0 
var turret_cost = 200 
var turret_power = -25
var num_turrets = 0  
var nuclear_plant_cost = 200 
var nuclear_plant_power = -25
var nuclear_plant = false 

func buy_headquarters(): 
	pass

func buy_refinery(): 
	pass 
	
func buy_barracks(): 
	pass

func buy_power_plant(): 
	pass

func buy_factory(): 
	pass

func buy_airport(): 
	pass

func buy_turret(): 
	pass

func buy_nuclear_plant(): 
	pass

# ------  GETTERS AND SETTERS  ------
func getBuildingsUI(): 
	return buildings_ui
	
func setBuildingsUI(bui): 
	buildings_ui = bui
	
	

