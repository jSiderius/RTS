extends NavigationRegion3D

# This script will eventually be used for instantiating units into the scene, or I'll do it in game and get rid of this 

var unit = preload("res://Scenes/Units/GeneralInfantry/Unit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	NavigationServer3D.set_debug_enabled(true)
	
func instantiateUnit(pos):
	# Instantiate the object and add it to the scene
	var instance = unit.instantiate()
	instance.position = pos
	add_child(instance)
	
