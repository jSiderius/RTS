extends Building

var min_unit_spawn_time_s = 45
var unit_spawn_time_s = 180
var spawn_time_depreciation = 0.87

func _ready(): 
	health = 100 
	health_bar = $HealthBar
	spawner()
	
func _process(delta): 
	health_bar.health = health
	super(delta)
	
func spawner():
	while true: 
		var t = min_unit_spawn_time_s
		if unit_spawn_time_s > t: 
			t = unit_spawn_time_s
			unit_spawn_time_s = unit_spawn_time_s * spawn_time_depreciation
		await get_tree().create_timer(t).timeout 
		instantiate_enemy()

var helicopter = preload("res://Scenes/Units/EnemyUnits/enemy_chopper.tscn")
func instantiate_enemy(): 
	var instance = helicopter.instantiate()
	var transf = instance.global_transform 
	transf = transf.scaled(Vector3(1, 1, 1))
	transf = transf.rotated(Vector3(0.0, 1.0, 0.0), -1.57079)
	transf = transf.translated(Vector3(3, 40, 0))
	
	instance.global_transform = transf  
	add_child(instance)

