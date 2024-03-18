extends Node3D

const MOVE_MARGIN = 20
const MOVE_SPEED = 60

func _process(delta): 
	var m_pos = get_viewport().get_mouse_position()
	calc_move(m_pos, delta)
		
# Calculates movement and moves the camera based on the distance of the mouse to the margins
func calc_move(m_pos, delta):
	var v_size = get_viewport().size
	var move_vec = Vector3()
	var change = sqrt(2.0) / 2.0
	if m_pos.x < MOVE_MARGIN:
		move_vec.x += change 
		move_vec.z -= change
	if m_pos.y < MOVE_MARGIN: 
		move_vec.x += change 
		move_vec.z += change
	if m_pos.x > v_size.x - MOVE_MARGIN: 
		move_vec.x -= change 
		move_vec.z += change
	if m_pos.y > v_size.y - MOVE_MARGIN: 
		move_vec.x -= change 
		move_vec.z -= change
	global_translate(move_vec * delta * MOVE_SPEED)
