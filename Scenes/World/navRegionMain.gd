extends NavigationRegion3D

var terrain = preload("res://Scenes/World/terrain.tscn")
var unit = preload("res://Scenes/Units/GeneralInfantry/Unit.tscn")
@onready var units = $Units

# Called when the node enters the scene tree for the first time.
func _ready():
	#instantiateGridBlock(Vector3(0.0, 0.0, 0.0))
	#instantiateUnit(Vector3(-120.0, 5.0, 8.0))
	#instantiateUnit(Vector3(-120.0, 5.0, 4.0))
	#instantiateUnit(Vector3(-120.0, 5.0, -4.0))
	#instantiateUnit(Vector3(-120.0, 5.0, -8.0))
	
	NavigationServer3D.set_debug_enabled(true)
	#NavigationServer3D.navmesh_set_debug_mode(NavigationServer.navmesh_get_debug_mode() | NavigationServer.DEBUG_DRAW_MESH)
	#bake_navigation_mesh()

#func _process(delta):
	#NavigationServer3D.navmesh_debug_draw()

func instantiateGridBlock(pos):
	# Instantiate the object and add it to the scene
	var instance = terrain.instantiate()
	instance.position = pos
	add_child(instance)
	
func instantiateUnit(pos):
	# Instantiate the object and add it to the scene
	var instance = unit.instantiate()
	instance.position = pos
	add_child(instance)
