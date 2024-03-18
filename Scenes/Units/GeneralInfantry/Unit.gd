extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var selection_ring = $SelectionRing
@onready var health_bar = %HealthBar
@export var SPEED = 20.0 
var target = null 
var attack_distance = 25.0
var health = 50.0
var health_pickup = 50.0
@export var dps = 40.0
var weapon_pickup = 40.0 

func _ready():
	nav_agent.debug_enabled = true

func _process(delta):
	health_bar.health = health
	
func _physics_process(delta): 
	if target and not is_instance_valid(target): 
		target = null
	if target: 
		update_target_location(target.global_transform.origin)
		target.select()
	if target and abs(global_transform.origin.distance_to(target.global_transform.origin)) < attack_distance and is_in_group("AttackingUnit") and (target.is_in_group("EnemyUnit") or target.is_in_group("Enemy_Building")): 
		attack(delta)
		return
	if nav_agent.is_target_reached(): 
		return
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position() 
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	
	var collision = move_and_collide(new_velocity * delta)
	if collision:
		# Collision occurred, handle it here
		var collider = collision.get_collider()
		if collider.is_in_group("ResourceCollectable") and is_in_group("ResourceTruck"):
			add_box(collider) 
		if collider.is_in_group("HealthCollectable") and is_in_group("HealableUnit") and health < 100:
			collider.get_parent().queue_free() 
			health += health_pickup
		if collider.is_in_group("WeaponUpgradeCollectable") and is_in_group("WeaponUpgradeUnit"): 
			if not %HeavyWeapon.visible: 
				%HeavyWeapon.visible = true 
				%LightWeapon.visible = false 
				dps += weapon_pickup
				collider.get_parent().queue_free() 

func attack(delta): 
	if target: 
		target.damage(dps * delta)

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)	

func add_box(collider): #Eventually add feature to have to bring it back to refinery
	collider.get_parent().queue_free() 
	GlobalData.money += 100  

func select(): 
	selection_ring.visible = true
	
func deselect(): 
	selection_ring.visible = false

func set_target(unit): 
	print("set_target()")
	target = unit
	target.select() 
	
func clear_target():
	if target: 
		target.deselect()
	target = null 
