extends PlayerState
class_name PlayerStateIdle

##
# @override
##
func _ready():
	_animation_player.play("walk")
	
##
# @override
##
func process(delta:float):
	var dir_input = _owner._dir_input
	
	if dir_input == Vector2.ZERO:
		return State.PLAYER_IDLE
		
	var towards = Utils.normalize_rotate_towards(_mesh.rotation_degrees.y, rad2deg(dir_input.angle() * -1))
	_mesh.rotation_degrees.y = lerp(_mesh.rotation_degrees.y, towards, _owner.ROTATION_SPEED * delta)
	_collision_shape.rotation.y = _mesh.rotation.y
	
	_owner._velocity.x = dir_input.x * _owner.WALK_SPEED
	_owner._velocity.z = dir_input.y * _owner.WALK_SPEED
	
	return -1