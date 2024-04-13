extends Turret

var is_ready = false 

func _ready(): 
	attack_targets = ["EnemyAirUnit", "EnemyGroundUnit"]
	super() 
	
func check_attack(delta):
	if target and is_instance_valid(target) and is_ready: 
		target.damage(dps * delta)
		
func set_ready(): 
	add_to_group("AttackableBuilding")
	is_ready = true
