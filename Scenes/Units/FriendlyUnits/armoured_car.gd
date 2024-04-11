extends Unit

@export var ac_dps = 40.0
@export var ac_speed = 40
var ac_attack_targets = ["EnemyGroundUnit", "EnemyBuilding"] 
var ac_other_targets = [] 

func _ready(): 
	SPEED = ac_speed
	dps = ac_dps
	attack_targets = ac_attack_targets
	other_targets = ac_other_targets 
