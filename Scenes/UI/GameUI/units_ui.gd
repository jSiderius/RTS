extends MainUI

func update_button_visibility(): 
	if GlobalData.num_barracks > 1: 
		%RIButton.disabled = false
	if GlobalData.num_factories > 0: 
		%TankButton.disabled = false 
	if GlobalData.num_factories > 1: 
		%ArmouredCarButton.disabled = false
	if GlobalData.num_airports > 0: 
		%MGChopperButton.disabled = false 

func update_price_energy_labels(): 
	%GIPrice.text = str(GlobalData.general_infantry_cost)
	%RIPrice.text = str(GlobalData.rocket_infantry_cost)
	%TankPrice.text = str(GlobalData.tank_cost)
	%ArmouredCarPrice.text = str(GlobalData.armoured_car_cost)  
	%MGChopperPrice.text = str(GlobalData.mg_chopper_cost) 
