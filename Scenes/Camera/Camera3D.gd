extends Camera3D

var speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Just adds movement functionality to the camera
func _process(delta):
	var motion = Vector3() 

	if Input.is_action_pressed("camera_right"):
		motion.x += 1
	if Input.is_action_pressed("camera_left"):
		motion.x -= 1
	if Input.is_action_pressed("camera_back"):
		motion.z += 1
	if Input.is_action_pressed("camera_front"):
		motion.z -= 1

	motion = motion.normalized()
	position += motion * speed * delta
