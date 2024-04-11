extends MainUI

func update_button_visibility(): 
	# Logic for disabling buttons on building progression
	if GlobalData.headquarters: 
		%RefineryButton.disabled = false 
		%PowerPlantButton.disabled = false 
	if GlobalData.num_refineries > 0 and GlobalData.num_power_plants > 0: %BarracksButton.disabled = false 
	if GlobalData.num_barracks > 0: 
		%UnitsButton.disabled = false
		%FactoryButton.disabled = false
		%Blocker1.visible = false 
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
func update_price_energy_labels(): 
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
	

