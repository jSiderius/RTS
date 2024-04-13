extends CanvasLayer

var end_screen = preload("res://Scenes/UI/PopupUI/end_screen.tscn")

func _on_no_pressed():
	var instance = end_screen.instantiate()
	var title = instance.get_node("Control/Container/MarginContainer/VBoxContainer/HBoxContainer2/Text")
	title.text = "Truce! Your opponents see your mercy and can't remember why they're fighting you in this little square"
	get_tree().get_root().add_child(instance)


func _on_yes_pressed():
	var instance = end_screen.instantiate()
	var title = instance.get_node("Control/Container/MarginContainer/VBoxContainer/HBoxContainer2/Text")
	title.text = "You Win! But you have to live with the moral repercussions and abandoning your humanaity for nuclear weapons"
	get_tree().get_root().add_child(instance)
