extends Node

# Track the score and number of attempts
var buildings_ui = true
var money = 0.0

var power_total = 100.0
var power_owned = 70.0
var power_used = 30.0
 

# ------  GETTERS AND SETTERS  ------
func getBuildingsUI(): 
	return buildings_ui
	
func setBuildingsUI(bui): 
	buildings_ui = bui
	
func getMoney():
	return money

func setMoney(m): 
	money = m 
	
func getPowerTotal(): 
	return power_total
	
func setPowerTotal(p): 
	power_total = p
	
func getPowerOwned():
	return power_owned
	
func setPowerOwned(p): 
	power_owned = p 
	
func getPowerUsed(): 
	return power_used
	
func setPowerUsed(p): 
	power_used = p
	

