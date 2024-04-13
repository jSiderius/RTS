extends Building
class_name Turret

var target = null 
var attack_targets = []
var dps = 40

func _ready(): 
	health = 100
	health_bar = $HealthBar
	_scan_attack_range()
	
func _process(delta):
	health_bar.health = health
	check_attack(delta)
	#_scan_attack_range() 
	super(delta)
	
func check_attack(delta):
	if target and is_instance_valid(target): 
		target.damage(dps * delta)
	
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

func _scan_attack_range(): 
	for body in %AttackRangeArea.get_overlapping_bodies(): 
		for t in attack_targets: 
			if body == target or not body.is_in_group(t): continue 
			target = body
			target.death.connect(_target_death)
			return 
			

