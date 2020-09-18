extends KinematicBody
class_name Player

const GRAVITY = Vector3.DOWN * 40
const WALK_SPEED = 8
const ROTATION_SPEED = 8

export(bool) var user_control = false
export(float) var movement_offset = 0

onready var _mesh = $MeshInstance
onready var _collision_shape = $CollisionShape

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
		
		if dir_input != Vector2.ZERO:
			var towards = Utils.normalize_rotate_towards(_mesh.rotation_degrees.y, rad2deg(dir_input.angle() * -1))
			_mesh.rotation_degrees.y = lerp(_mesh.rotation_degrees.y, towards, ROTATION_SPEED * delta)
			_collision_shape.rotation.y = _mesh.rotation.y
			
		_velocity.x = dir_input.x * WALK_SPEED
		_velocity.z = dir_input.y * WALK_SPEED
	
	_velocity = move_and_slide(_velocity, Vector3.UP)
		