extends KinematicBody
class_name Player

const GRAVITY = Vector3.DOWN * 20
const WALK_SPEED = 5

export(bool) var user_control = false
export(float) var movement_offset = 0

var _velocity = Vector3()

##
# @override
##
func _physics_process(delta):
	# Gravity.
	_velocity += GRAVITY * delta
	
	# Directional input.
	if user_control:
		var dir_input = UserInput.get_directional_input().rotated(movement_offset)
		_velocity.x = dir_input.x * WALK_SPEED
		_velocity.z = dir_input.y * WALK_SPEED
	
	_velocity = move_and_slide(_velocity, Vector3.UP)
		