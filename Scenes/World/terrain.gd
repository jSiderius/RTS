extends Node3D

var grid_block = preload("res://Scenes/World/grid_block.tscn")
@export var terrain_width : int = 10
@export var terrain_height : int = 10
@export var color_0 : Color 
@export var color_1 : Color 
@export var color_2 : Color 
@onready var color_options : Array = [color_0, color_1, color_2]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(terrain_width): 
		for j in range(terrain_height):  
			var y = randf_range(1.0, 2.0)
			y = round(randf()) + 1
			
			instantiateGridBlock(Vector3(float(i) - terrain_width / 2.0, float(y), float(j) - terrain_height / 2.0))
	
func instantiateGridBlock(pos):
	# Instantiate the object and add it to the scene
	var instance = grid_block.instantiate()
	add_child(instance)
	
	# Get the mesh of the instance
	# Set the position based on the pos argument and the scale of the box mesh
	var box_mesh = instance.get_node("BoxMesh")
	if !box_mesh: return 
	instance.position = Vector3(pos.x * box_mesh.scale.x, pos.y, pos.z * box_mesh.scale.z)
	
	# Get the material of the object
	var original_material = box_mesh.get_surface_override_material(0)
	if !original_material: return
	
	# Duplicate the material so that all instances don't work off of the same material
	# Set the color parameter to a random color
	# Set the box meshs material to the duplicate
	var shader_material = original_material.duplicate() 
	shader_material.set_shader_parameter("inner_color", color_options[randi()%3])
	box_mesh.set_surface_override_material(0, shader_material)
	
