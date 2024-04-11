extends Building

var target = null 
var attack_targets = ["EnemyAirUnit", "EnemyGroundUnit"]
var dps = 40
#var health = 100 

func _ready(): 
	health = 100
	
func _process(delta): 
	if target and is_instance_valid(target): 
		target.damage(dps * delta)
	super(delta)
	
func _on_attack_range_entered(body):
	if target: return
	for t in attack_targets: 
		if not body.is_in_group(t): continue
		target = body
		target.death.connect(_target_death) 
		return 

func _on_attack_range_exited(body):
	if body == target: target = null
	
func _target_death(): 
	target = null
