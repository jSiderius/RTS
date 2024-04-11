extends Building 

@export var type = 1 
func _ready(): 
	if type == 1: %PowerPlant1.visible = true
	if type == 2: %PowerPlant2.visible = true
	if type == 3: %PowerPlant3.visible = true
	health_bar = $HealthBar
