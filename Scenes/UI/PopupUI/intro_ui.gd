extends CanvasLayer

# Very simple script to delete the node on click
func _on_ok_pressed():
	queue_free()

func _on_end_pressed(): 
	get_tree().quit()
