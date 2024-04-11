extends Building


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cash_range_area_body_entered(body):
	if body.is_in_group("ResourceTruck") and body.carrying_box: 
		$SelectionRing.visible = false
		body.cash_box() 

func _on_cash_range_area_body_exited(body):
	pass # Replace with function body.


