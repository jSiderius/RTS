extends Node3D

@onready var selection_ring = %SelectionRing

func select(): 
	selection_ring.visible = true	

func deselect(): 
	selection_ring.visible = false
