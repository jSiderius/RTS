extends Node3D

@onready var percentages : Array = [%ten, %twenty, %thirty, %fourty, %fifty, %sixty, %seventy, %eighty, %ninety, %onehundred] 
var health = 92.0
@export var health_color : Color = Color(0, 1, 0, 1)
@export var damage_color : Color = Color(1, 0, 0, 1)

func _ready():
	# Prevents all nodes from acting on the same material
	for bar in percentages: 
		var original_material = bar.get_surface_override_material(0)
		if !original_material: continue
		bar.set_surface_override_material(0, original_material.duplicate())

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var health_bars = int(floor(health / 10) )
	for i in range(health_bars): 
		percentages[i].get_surface_override_material(0).albedo_color = health_color
	for i in range(10 - health_bars): 
		percentages[i + health_bars].get_surface_override_material(0).albedo_color = damage_color
		
		
	
