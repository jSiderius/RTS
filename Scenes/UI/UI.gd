extends CanvasLayer
class_name UI

@onready var time_label = %Time 
@onready var money_label = %Money
@onready var power_empty = %PowerEmpty
@onready var power_capspace = %PowerCapSpace
@onready var power_used = %PowerUsed

# Declaration of time variable and setter that also updates the in-scene label
@onready var time = Time.get_ticks_msec():
	set(new_time):
		time = new_time
		_update_time_label()

signal headquarters_pressed() 
signal quarters_pressed()
signal refinery_pressed
signal factory_pressed()
signal airport_pressed() 
signal nuclear_plant_pressed() 
signal power_plant_pressed() 


func _ready(): 
	_update_time_label()
	_update_price_energy_labels()

func _process(delta):
	time = floor(Time.get_ticks_msec() / 1000.0)
	_update_money_label()
	_update_power_bars()
	
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

# Update function for the power bars on the left hand side
# I intend to update this into blocks so it is more clear how much power is beingused 
func _update_power_bars(): 
	power_empty.size_flags_stretch_ratio = ( GlobalData.power_total -  GlobalData.power_owned ) / GlobalData.power_total
	power_capspace.size_flags_stretch_ratio = ( GlobalData.power_owned - GlobalData.power_used ) / GlobalData.power_total
	power_used.size_flags_stretch_ratio = GlobalData.power_used / GlobalData.power_total
	
# When the buildings button is pressed change the global data to indicate which page is being displayed
func _on_button_pressed(): 
		GlobalData.buildings_ui = true

# When the soldier button is pressed change the global data to indicate which page is being displayed
func _on_button_2_pressed(): 
	GlobalData.buildings_ui = false

# Emit signal to be picked up by the game
func _headquarters_button_pressed():
	emit_signal("headquarters_pressed")
func _quarters_button_pressed():
	emit_signal("quarters_pressed")
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



