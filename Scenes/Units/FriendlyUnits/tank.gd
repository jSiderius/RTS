extends Unit

@export var tank_dps = 150.0
@export var tank_speed = 8
var tank_attack_targets = ["EnemyGroundUnit", "EnemyBuilding"]
var tank_other_targets = [] 

func _ready(): 
	SPEED = tank_speed
	dps = tank_dps
	attack_targets = tank_attack_targets
	other_targets = tank_other_targets

