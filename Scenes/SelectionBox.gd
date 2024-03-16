extends Control

var m_pos = Vector2()
var start_sel_pos = Vector2() 
const sel_box_col = Color(0,1,0)
const sel_box_line_width = 3.0 
var calls = 0 

func _draw(): 
	prints("_draw()", calls)
	calls += 1 
	if visible and start_sel_pos != m_pos: 
		draw_line(start_sel_pos, Vector2(m_pos.x, start_sel_pos.y), sel_box_col, sel_box_line_width)
		draw_line(start_sel_pos, Vector2(start_sel_pos.x, m_pos.y), sel_box_col, sel_box_line_width)
		draw_line(m_pos, Vector2(m_pos.x, start_sel_pos.y), sel_box_col, sel_box_line_width)
		draw_line(m_pos, Vector2(start_sel_pos.x, m_pos.y), sel_box_col, sel_box_line_width)
		
func _process(delta):
	#_draw()
	queue_redraw()


