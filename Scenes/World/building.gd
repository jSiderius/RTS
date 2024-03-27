extends Node3D

@onready var health_bar = $HealthBar
var health = 0


func _process(delta):
	health_bar.health = health

func health_bar_invisible(): 
	health_bar.visible = false

