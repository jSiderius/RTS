extends Node3D

const MOVE_MARGIN = 20
const MOVE_SPEED = 100
const MARGIN_X = 0.15
const MARGIN_Y = 0.15
const MARGIN_ERROR = 40

func _process(delta): 
	var m_pos = get_viewport().get_mouse_position()	
	calc_move(m_pos, delta)
		
# Calculates movement and moves the camera based on the distance of the mouse to the margins
func calc_move(m_pos, delta):
	var v_size = get_viewport().get_visible_rect().end
	# Give a small margin outside of the screen for the home bar and info bar 
	if m_pos.x < -MARGIN_ERROR or m_pos.y < -MARGIN_ERROR or m_pos.x > v_size.x + MARGIN_ERROR or m_pos.y > v_size.y + MARGIN_ERROR: return
	
	# Set the margins as a percentage of the screen size 
	var mar_x = v_size.x * MARGIN_X
	var mar_y = v_size.y * MARGIN_Y
	var move_vec = Vector3()
	
	# Because the camera is at 45 degrees and unit circle 
	var change = sqrt(2.0) / 2.0
	
	# Check if the camera should move and act accordingly 
	if m_pos.x < mar_x:
		move_vec.x += change 
		move_vec.z -= change
	if m_pos.y < mar_y: 
		move_vec.x += change 
		move_vec.z += change
	if m_pos.x > v_size.x - mar_x / 2: 
		move_vec.x -= change 
		move_vec.z += change
	if m_pos.y > v_size.y - mar_y: 
		move_vec.x -= change 
		move_vec.z -= change
	global_translate(move_vec * delta * MOVE_SPEED)
