extends Enemy

var patrol_points = [] 
var patrol_index = 0
#var state = "Defend"#States: Patrol, Defend, Attack, Push base 

var enemy_gi_attack_targets : Array = ["GroundUnit", "AirTruck", "ResourceTruck", "AttackableBuilding", "AttackableFriendlyBuilding"]
#var other_targets : Array = []

var enemy_gi_dps = 30
var enemy_gi_speed = 20
@onready var animation_tree = $CharacterArmature/AnimationTree

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
	_process_animation(delta)
	super(delta) 
	
func _process_animation(delta): 
	if anim_moving: 
		animation_tree.set("parameters/walking/transition_request", "true")
	else: 
		animation_tree.set("parameters/walking/transition_request", "false")
	if anim_attack: 
		animation_tree.set("parameters/attacking/transition_request", "true")
	else: 
		animation_tree.set("parameters/attacking/transition_request", "false")
	if anim_damaged: 
		animation_tree.set("parameters/damaged/transition_request", "true")
	else: 
		animation_tree.set("parameters/damaged/transition_request", "false")
	if anim_moving and anim_attack: 
		animation_tree.set("parameters/moving_attacking/transition_request", "true")
	else: 
		animation_tree.set("parameters/moving_attacking/transition_request", "false")
		
func state_process(): 
	if state == "Patrol": 
		if storming_unit: 
			set_storm()
			return 
		if nav_agent.is_navigation_finished() and patrol_points.size() > 0:
			patrol_index = patrol_index + 1
			if patrol_index == patrol_points.size(): patrol_index = 0
			update_target_location(patrol_points[patrol_index])
	if state == "Attack": # Targeting handled elsewhere  
		pass 
	if state == "Storm":
		#if not target: 
		set_storm()
		

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
		if storming_unit: 
			set_patrol()
		else: 
			set_storm() 
