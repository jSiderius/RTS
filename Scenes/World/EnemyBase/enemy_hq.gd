extends StaticBody3D

# Simple script for health and selectability

@onready var selection_ring = $SelectionRing
@onready var health_bar = %HealthBar
var health = 100.0

func _process(delta):
	health_bar.health = health

func select():
	selection_ring.visible = true
	
func deselect(): 
	selection_ring.visible = false
	
var popup = preload("res://Scenes/UI/PopupUI/end_screen.tscn")
func damage(d):
	health -= d
	if health <= 0: 
		queue_free()
		var instance = popup.instantiate()
		var title = instance.get_node("Control/Container/MarginContainer/VBoxContainer/HBoxContainer2/Text")
		title.text = "You Win!!!!!"
		get_tree().get_root().add_child(instance)


