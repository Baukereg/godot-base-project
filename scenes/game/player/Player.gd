extends KinematicBody
class_name Player

const GRAV = Vector3.DOWN * 20
const WALK_SPEED = 5

export(bool) var user_control = false

var _velocity = Vector3()

##
# @override
##
func _physics_process(delta):
	if !user_control:
		return
		
	# Gravity.
	_velocity += GRAV * delta
	
	# Directional input.
	var dir_input = UserInput.get_directional_input()
	_velocity.x = dir_input.x * WALK_SPEED
	_velocity.z = dir_input.y * WALK_SPEED
	
	_velocity = move_and_slide(_velocity, Vector3.UP)
		