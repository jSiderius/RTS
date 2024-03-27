extends CanvasLayer
class_name UI

@onready var time_label = %Time 
@onready var money_label = %Money

# Declaration of time variable and setter that also updates the in-scene label
@onready var time = Time.get_ticks_msec():
	set(new_time):
		time = new_time
		_update_time_label()

signal headquarters_pressed() 
signal barracks_pressed()
signal refinery_pressed
signal factory_pressed()
signal airport_pressed() 
signal nuclear_plant_pressed() 
signal power_plant_pressed() 


func _ready(): 
	_update_time_label()
	_update_price_energy_labels()
	_init_power_bars()
	#_update_transparancy()

func _process(delta):
	time = floor(Time.get_ticks_msec() / 1000.0)
	_update_money_label()
	_update_power_bars()
	_update_buildings_enabling()
	
func _update_buildings_enabling(): 
	if not is_in_group("BuildingsUI"): return
	
	# Logic for disabling buttons on building progression
	if GlobalData.headquarters: 
		%RefineryButton.disabled = false 
		%PowerPlantButton.disabled = false 
	if GlobalData.num_refineries > 0 and GlobalData.num_power_plants > 0: %BarracksButton.disabled = false 
	if GlobalData.num_barracks > 0: 
		%UnitsButton.disabled = false
		%FactoryButton.disabled = false 
	if GlobalData.num_factories > 0: %AirportButton.disabled = false 
	if GlobalData.num_airports > 0: %NuclearPlantButton.disabled = false 
	
	# Logic for disabling buttons during wait times
	if GlobalData.headquarters_waiting: 
		%HeadQuartersButton.disabled = true
	if GlobalData.headquarters_waiting == false: 
		%HeadQuartersButton.disabled = false
	if GlobalData.refineries_waiting: 
		%RefineryButton.disabled = true
	if GlobalData.refineries_waiting == false: 
		%RefineryButton.disabled = false
	if GlobalData.barracks_waiting: 
		%BarracksButton.disabled = true
	if GlobalData.barracks_waiting == false: 
		%BarracksButton.disabled = false
	if GlobalData.power_plants_waiting: 
		%PowerPlantButton.disabled = true
	if GlobalData.power_plants_waiting == false: 
		%PowerPlantButton.disabled = false
	if GlobalData.factories_waiting: 
		%FactoryButton.disabled = true
	if GlobalData.factories_waiting == false: 
		%FactoryButton.disabled = false
	if GlobalData.airports_waiting: 
		%AirportButton.disabled = true
	if GlobalData.airports_waiting == false: 
		%AirportButton.disabled = false
	if GlobalData.nuclear_plant_waiting: 
		%NuclearPlantButton.disabled = true
	if GlobalData.nuclear_plant_waiting == false: 
		%NuclearPlantButton.disabled = false
	
	
	
# Updates the label values so they can be set from global_data.gd
func _update_price_energy_labels(): 
	%HeadQuartersPrice.text = str(GlobalData.headquarters_cost)
	%HeadQuartersEnergy.text = str(GlobalData.headquarters_power)
	%RefineryPrice.text = str(GlobalData.refinery_cost)
	%RefineryEnergy.text = str(GlobalData.refinery_power)
	%BarracksPrice.text = str(GlobalData.barracks_cost)
	%BarracksEnergy.text = str(GlobalData.barracks_power)
	%PowerPlantPrice.text = str(GlobalData.power_plant_cost)
	%PowerPlantEnergy.text = str(GlobalData.power_plant_power)
	%TurretPrice.text = str(GlobalData.turret_cost)
	%TurretEnergy.text = str(GlobalData.turret_power)
	%FactoryPrice.text = str(GlobalData.factory_cost)
	%FactoryEnergy.text = str(GlobalData.factory_power)
	%AirportPrice.text = str(GlobalData.airport_cost)
	%AirportEnergy.text = str(GlobalData.airport_power)
	%NuclearPlantPrice.text = str(GlobalData.nuclear_plant_cost)
	%NuclearPlantEnergy.text = str(GlobalData.nuclear_plant_power)
	
# Update function for the time label
func _update_time_label(): 
	if (int(time) % 60 < 10.0): 
		time_label.text = str( ( time - (int(time) % 60) ) / 60.0) + ":0" + str(int(time) % 60)
	else: 
		time_label.text = str( ( time - (int(time) % 60) ) / 60.0) + ":" + str(int(time) % 60)

# Update function for the money label
func _update_money_label(): 
	money_label.text = "$" + str(floor(GlobalData.money))

var power_bar = preload("res://Scenes/UI/power_bar.tscn")
var bars : Array = [] 
var num_bars = 50
func _init_power_bars(): 
	if not is_in_group("BuildingsUI"): return
	var container = %PowerContainer
	for i in range(GlobalData.power_total): 
		var instance = power_bar.instantiate()
		instance.size_flags_vertical = 3
		bars.append(instance)
		container.add_child(instance)
		
# Update function for the power bars on the left hand side
# I intend to update this into blocks so it is more clear how much power is being used 
func _update_power_bars(): 
	if not is_in_group("BuildingsUI"): return

	for i in range(GlobalData.power_total):
		var ind = GlobalData.power_total - i - 1
		if i < GlobalData.power_used: 
			bars[ind].theme_type_variation = "PowerPanelContainerUsed"
		elif i < GlobalData.power_owned:
			bars[ind].theme_type_variation = "PowerPanelContainerCapSpace"
		else: 
			bars[ind].theme_type_variation = "PowerPanelContainerEmpty"
	
# When the buildings button is pressed change the global data to indicate which page is being displayed
func _on_button_pressed(): 
		GlobalData.buildings_ui = true

# When the soldier button is pressed change the global data to indicate which page is being displayed
func _on_button_2_pressed(): 
	GlobalData.buildings_ui = false

# Emit signal to be picked up by the game
func _headquarters_button_pressed():
	emit_signal("headquarters_pressed")
func _barracks_button_pressed():
	emit_signal("barracks_pressed")
func _refinery_button_pressed():
	emit_signal("refinery_pressed")
func _factory_button_pressed():
	emit_signal("factory_pressed")
func _airport_button_pressed():
	emit_signal("airport_pressed")
func _nuclear_plant_button_pressed():
	emit_signal("nuclear_plant_pressed")
func _power_plant_button_pressed(): 
	emit_signal("power_plant_pressed")
	
#TODO: implement unit buying, signals, ...



