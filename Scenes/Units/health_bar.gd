extends Node3D

@onready var percentages : Array = [%ten, %twenty, %thirty, %fourty, %fifty, %sixty, %seventy, %eighty, %ninety, %onehundred] 
@export var health_color : Color = Color(0, 1, 0, 1)
@export var damage_color : Color = Color(1, 0, 0, 1)
var health = 90.0

func _ready():
	# Prevents all nodes from acting on the same material
	for bar in percentages: 
		var original_material = bar.get_surface_override_material(0)
		if !original_material: continue
		bar.set_surface_override_material(0, original_material.duplicate())


func _process(delta):
	# Set the  first (floor of health in tens) mesh's to health color, the rest to damage color
	# TODO: Generalize the amount of mesh's 
	var health_bars = int(floor(health / 10) )
	for i in range(health_bars): 
		if i >= percentages.size() or i < 0: continue
		percentages[i].get_surface_override_material(0).albedo_color = health_color
	for i in range(10 - health_bars): 
		if i >= percentages.size() or i < 0: continue
		percentages[i + health_bars].get_surface_override_material(0).albedo_color = damage_color
		
	
