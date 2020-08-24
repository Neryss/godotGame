extends entity

var speed : int = 400
var maxSpeed : int = 500
var acceleration : int = 1000
var motion : Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	move_player_test(delta)


func get_input_axis() -> Vector2:
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	axis.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return(axis.normalized())


func apply_friction(amount) -> void:
	if(motion.length() > amount):
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO


func apply_movement(acceleration_value) -> void:
	motion += acceleration_value
	if(motion.length() > maxSpeed):
		motion = motion.clamped(maxSpeed)


func move_player_test(delta) -> void:
	var axis = get_input_axis()
	if(axis == Vector2.ZERO):
		motion = Vector2.ZERO
	else:
		if(motion.length() > maxSpeed):
			motion = motion.clamped(maxSpeed)
		motion = move_and_slide(axis * speed)
		print(motion)


#Smoother approach, way too slippy for the shooter style
func move_player(delta):
	var axis = get_input_axis()
	if(axis == Vector2.ZERO):
		#Don't know if I keep the slow down or not
		#apply_friction(acceleration * delta)
		motion = Vector2.ZERO
	else:
		apply_movement(axis * acceleration * delta)
	motion = move_and_slide(motion)
