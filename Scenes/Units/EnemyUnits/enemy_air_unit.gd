extends Enemy
class_name EnemyAirUnit

var patrol_points = [] 
var patrol_index = 0
#var state = "Defend"#States: Patrol, Defend, Attack, Push base 

var enemy_air_attack_targets : Array = ["GroundUnit", "AirUnit", "AttackableBuilding"]

var enemy_air_dps = 30
var enemy_air_speed = 80
var rotor_rotation_speed = 20.0

@onready var rotor = $Mesh/RotorBase

func _ready(): 
	super()
	SPEED = enemy_air_speed
	attack_targets = enemy_air_attack_targets
	dps = enemy_air_dps
	set_patrol() 

func _process(delta): 
	rotor.rotate_y(rotor_rotation_speed * delta)
	super(delta)
	
func state_process(): 
	if state == "Patrol": 
		if storming_unit:
			set_storm()
		if nav_agent.is_navigation_finished() and patrol_points.size() > 0:
			patrol_index = patrol_index + 1
			if patrol_index == patrol_points.size(): patrol_index = 0
			update_target_location(patrol_points[patrol_index])
	if state == "Storm": 
		set_storm()
		#if not target: 
		
		
func set_patrol(): 
	state = "Patrol"
	patrol_index = 0
	patrol_points = [] 
	patrol_points = points_in_circle(global_transform.origin, 160, 40)
	update_target_location(patrol_points[0])

func points_in_circle(center: Vector3, radius: float, n: int) -> Array:
	var points = []
	var angle_increment = 2 * PI / n

	for i in range(n):
		var angle = i * angle_increment
		var x = center.x + radius * cos(angle)
		var y = center.y
		var z = center.z + radius * sin(angle)
		var point = Vector3(x, y, z)
		points.append(point)

	return points

func update_target_location(target_location):
	nav_agent.set_target_position(Vector3(target_location.x, -20, target_location.z))	

#func attack(delta): 
	#pass 
