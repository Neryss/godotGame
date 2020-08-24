extends entity

var speed : int = 250
var maxSpeed : int = 500
var acceleration : int = 1000
var motion : Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	move_player_test()


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

#
func move_player_test() -> void:
	var axis = get_input_axis()
	if(axis == Vector2.ZERO):
		motion = Vector2.ZERO
	else:
		if(motion.length() > maxSpeed):
			motion = motion.clamped(maxSpeed)
		motion = move_and_slide(axis * speed)
		print(motion)
