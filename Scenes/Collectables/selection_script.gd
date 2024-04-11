extends Node3D

@onready var selection_ring = %SelectionRing

# This is just a basic selection script used by most of the collectables
# The Unit script determines how to behave based on the collectables groups, but these functions are nice to have
# I honestly don't know if I'm using this anywhere but just leaving it 
func select(): 
	selection_ring.visible = true	

func deselect(): 
	selection_ring.visible = false
