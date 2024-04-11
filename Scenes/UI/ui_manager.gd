extends Node

@onready var buildings_ui = %BuildingsUI
@onready var units_ui = %UnitsUI

func _ready(): 
	buildings_ui.buildings_pressed.connect(_on_buildings_pressed)
	buildings_ui.units_pressed.connect(_on_units_pressed)
	units_ui.buildings_pressed.connect(_on_buildings_pressed)
	units_ui.units_pressed.connect(_on_units_pressed)
	
func _on_buildings_pressed():
	buildings_ui.transform.origin = Vector2(0, 0)
	units_ui.transform.origin = Vector2(10000, 10000)
	
	move_child(buildings_ui, get_child_count() - 1)
	
func _on_units_pressed(): 
	units_ui.transform.origin = Vector2(0, 0)
	buildings_ui.transform.origin = Vector2(10000, 10000)
	move_child(units_ui, get_child_count() - 1)

