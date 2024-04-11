extends Enemy

var patrol_points = [] 
var patrol_index = 0
#var state = "Defend"#States: Patrol, Defend, Attack, Push base 

var enemy_gi_attack_targets : Array = ["GroundUnit", "AirTruck", "ResourceTruck"]
#var other_targets : Array = []

var enemy_gi_dps = 30
var enemy_gi_speed = 20

func _ready(): 
	set_patrol() 
	super()
	SPEED = enemy_gi_speed
	attack_targets = enemy_gi_attack_targets
	dps = enemy_gi_dps
	selection_ring = $SelectionRing
	health_bar = %HealthBar
	nav_agent = $NavigationAgent3D
	
func _process(delta):
	super(delta) 
	 

func state_process(): 
	if state == "Patrol": 
		if nav_agent.is_navigation_finished() and patrol_points.size() > 0:
			patrol_index = patrol_index + 1
			if patrol_index == patrol_points.size(): patrol_index = 0
			update_target_location(patrol_points[patrol_index])

func set_patrol(): 
	state = "Patrol"
	patrol_index = 0
	var direction_vector = Vector3(randi() % 10000, 0, randi() % 10000).normalized() 
	patrol_points = []
	patrol_points.append(global_transform.origin + direction_vector * 40)
	patrol_points.append(global_transform.origin + direction_vector * -40)
	update_target_location(patrol_points[0])

func set_attack(t):
	state = "Attack"
	target = t
	
func patrol(): 
	pass

func _on_detect_body_exited(body):
	if body == target: 
		target = null
		set_patrol()
