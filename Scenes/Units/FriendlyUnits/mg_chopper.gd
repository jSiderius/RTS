extends Unit

@export var mg_chopper_dps = 50.0
@export var mg_chopper_speed = 80
@export var mg_chopper_range = 200
var mg_chopper_attack_targets = ["EnemyAirUnit", "EnemyGroundUnit"] 
var mg_chopper_other_targets = []

func _ready(): 
	SPEED = mg_chopper_speed
	dps = mg_chopper_dps
	attack_distance = mg_chopper_range
	attack_targets = mg_chopper_attack_targets
	other_targets = mg_chopper_other_targets

