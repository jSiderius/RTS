extends Control

var m_pos = Vector2()
var select_pos = Vector2() 
const box_color = Color(0,1,0)
const box_line_width = 3.0 

func _draw():  
	# Make sure the box is visible, and the mouse and selection start point are not the same
	if not visible or m_pos == select_pos: 
		return
	
	# Draw the box to screen
	draw_line(select_pos, Vector2(m_pos.x, select_pos.y), box_color, box_line_width)
	draw_line(select_pos, Vector2(select_pos.x, m_pos.y), box_color, box_line_width)
	draw_line(m_pos, Vector2(m_pos.x, select_pos.y), box_color, box_line_width)
	draw_line(m_pos, Vector2(select_pos.x, m_pos.y), box_color, box_line_width)

# Trigger _draw() 
func _process(delta):
	queue_redraw()


