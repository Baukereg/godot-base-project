extends StateInstance
class_name PlayerStateIdle

var _animation_player

##
# @override
##
func _ready():
	_owner._animation_player.play("walk")
	
##
# @override
##
func process(delta:float):
	var dir_input = _owner._dir_input
	
	if dir_input == Vector2.ZERO:
		return State.PLAYER_IDLE
		
	var towards = Utils.normalize_rotate_towards(_owner.rotation_degrees.y, rad2deg(dir_input.angle() * -1))
	_owner.rotation_degrees.y = lerp(_owner.rotation_degrees.y, towards, _owner.ROTATION_SPEED * delta)
	
	_owner._velocity.x = dir_input.x * _owner.WALK_SPEED
	_owner._velocity.z = dir_input.y * _owner.WALK_SPEED
	
	return -1