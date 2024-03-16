extends Node3D

const MOVE_MARGIN = 20
const MOVE_SPEED = 60

const ray_length = 2000
@onready var cam = $Camera3D

var selected_units = []
@onready var selection_box = $SelectionBox
var start_sel_pos = Vector2()

func _process(delta): 
	var m_pos = get_viewport().get_mouse_position()
	calc_move(m_pos, delta)
	if Input.is_action_just_pressed("main_command"):
		move_selected_units(m_pos)
	if Input.is_action_just_pressed("alt_command"):
		selection_box.start_sel_pos = m_pos
		start_sel_pos = m_pos
	if Input.is_action_pressed("alt_command"):
		#print("call")
		selection_box.m_pos = m_pos
		selection_box.visible = true
	else: 
		selection_box.visible = false
	if Input.is_action_just_released("alt_command"):
		select_units(m_pos)
	
func calc_move(m_pos, delta):
	var v_size = get_viewport().size
	var move_vec = Vector3()
	if m_pos.x < MOVE_MARGIN:
		move_vec.z -= 1
	if m_pos.y < MOVE_MARGIN: 
		move_vec.x += 1
	if m_pos.x > v_size.x - MOVE_MARGIN: 
		move_vec.z += 1
	if m_pos.y > v_size.y - MOVE_MARGIN: 
		move_vec.x -= 1
	#move_vec = move_vec.rotate(Vector3(0,1,0). rotation_degrees.y)
	global_translate(move_vec * delta * MOVE_SPEED)

func move_selected_units(m_pos):
	var result = raycast_from_mouse(m_pos, 1)
	if result: 
		for unit in selected_units: 
			unit.update_target_location(result.position)
		
func move_all_units(m_pos):
	#var collision_mask = 1 << 2 #| 1 << layer2 | ... | 1 << layerN
	var result = raycast_from_mouse(m_pos, 1)
	if result: 
		get_tree().call_group("units", "update_target_location", result.position)

func select_units(m_pos): 
	var new_selected_units = [] 
	if m_pos.distance_squared_to(start_sel_pos) < 30: 
		var u = get_unit_under_mouse(m_pos)
		if u: 
			new_selected_units.append(u)
	else: 
		new_selected_units = get_units_in_box(start_sel_pos, m_pos)
	for unit in selected_units: 
		unit.deselect()
	for unit in new_selected_units: 
		unit.select()
	selected_units = new_selected_units
	
func get_unit_under_mouse(m_pos): 
	var result = raycast_from_mouse(m_pos, 0x1)
	#print(result, get_groups())
	if result and result.collider.is_in_group("units"): #Unit logic
		return result.collider #Not sure if I'm using colliders rn

func get_units_in_box(top_left, bot_right): 
	print("get_units_in_box()")
	if top_left.x > bot_right.x: 
		var temp = top_left.x
		top_left.x = bot_right.x
		bot_right.x = temp
	if top_left.y > bot_right.y: 
		var temp = top_left.y
		top_left.y = bot_right.y
		bot_right.y = temp
	var box = Rect2(top_left, bot_right - top_left)
	var box_selected_units = [] 
	for unit in get_tree().get_nodes_in_group("units"):
		if box.has_point(cam.unproject_position(unit.global_transform.origin)): 
			box_selected_units.append(unit)
	return box_selected_units
	
func raycast_from_mouse(m_pos, collision_mask):
	var ray_start = cam.global_transform.origin #cam.project_ray_origin(m_pos)
	var ray_end = ray_start + cam.project_ray_normal(m_pos) * ray_length
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_start
	params.to = ray_end
	params.exclude = []
	params.collision_mask = collision_mask #COLLISION MASK CAN BE HARD CODED IN FROM ITS BINARY, LOOK INTO THIS IF IT BECOMES RELEVANT
	
	return space_state.intersect_ray(params)
