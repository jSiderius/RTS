extends Node
class_name MainUI

@onready var time_label = %Time 
@onready var money_label = %Money
var bars : Array = [] 

# Declaration of time variable and setter that also updates the in-scene label
@onready var time = Time.get_ticks_msec():
	set(new_time):
		time = new_time
		update_time_label()

func _ready(): 
	update_time_label()
	update_price_energy_labels()
	update_price_energy_labels()
	init_power_bars()

func _process(delta):
	time = floor(Time.get_ticks_msec() / 1000.0)
	update_money_label()
	update_power_bars()
	update_button_visibility()

func update_button_visibility(): 
	pass
	
func update_price_energy_labels(): 
	pass
	
# Update function for the time label
func update_time_label(): 
	if (int(time) % 60 < 10.0): 
		time_label.text = str( ( time - (int(time) % 60) ) / 60.0) + ":0" + str(int(time) % 60)
	else: 
		time_label.text = str( ( time - (int(time) % 60) ) / 60.0) + ":" + str(int(time) % 60)

# Update function for the money label
func update_money_label():
	money_label.text = "$" + str(floor(GlobalData.money))
	
var power_bar = preload("res://Scenes/UI/power_bar.tscn")
func init_power_bars(): 
	var container = %PowerContainer
	for i in range(GlobalData.power_total): 
		var instance = power_bar.instantiate()
		instance.size_flags_vertical = 3
		bars.append(instance)
		container.add_child(instance)
		
# Update function for the power bars on the left hand side
# I intend to update this into blocks so it is more clear how much power is being used 
func update_power_bars(): 
	for i in range(GlobalData.power_total):
		var ind = GlobalData.power_total - i - 1
		if i < GlobalData.power_used: 
			bars[ind].theme_type_variation = "PowerPanelContainerUsed"
		elif i < GlobalData.power_owned:
			bars[ind].theme_type_variation = "PowerPanelContainerCapSpace"
		else: 
			bars[ind].theme_type_variation = "PowerPanelContainerEmpty"
	

signal headquarters_pressed() 
signal barracks_pressed()
signal refinery_pressed()
signal factory_pressed()
signal airport_pressed() 
signal nuclear_plant_pressed() 
signal power_plant_pressed() 
signal general_infantry_pressed()
signal rocket_infantry_pressed() 
signal tank_pressed() 
signal armoured_car_pressed() 
signal mg_helicopter_pressed() 
signal rocket_helicopter_pressed() 
signal buildings_pressed()
signal units_pressed() 
signal mouse_entered()
signal mouse_exited()

# Emit signal to be picked up by UI manager
func _buildings_pressed(): 
	emit_signal("buildings_pressed")
	
func _units_pressed(): 
	emit_signal("units_pressed")
	
# Emit signal to be picked up by the game
func _on_control_mouse_entered():
	emit_signal("mouse_entered")
func _on_control_mouse_exited():
	emit_signal("mouse_exited")
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
	
func _general_infantry_button_pressed(): 
	emit_signal("general_infantry_pressed")
func _rocket_infantry_button_pressed(): 
	emit_signal("rocket_infantry_pressed")
func _tank_button_pressed(): 
	emit_signal("tank_pressed")
func _armoured_car_button_pressed(): 
	emit_signal("armoured_car_pressed")
func _mg_helicopter_button_pressed(): 
	emit_signal("mg_helicopter_pressed")
func _rocket_helicopter_button_pressed(): 
	emit_signal("rocket_helicopter_pressed")
