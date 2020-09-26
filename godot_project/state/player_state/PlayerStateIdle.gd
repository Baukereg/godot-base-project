extends StateInstance
class_name PlayerStateWalk

##
# @override
##
func _ready():
	_owner._velocity.x = 0
	_owner._velocity.z = 0
	
	_owner._animation_player.play("idle")
	
##
# @override
##
func process(delta:float):
	if _owner.is_on_floor():
		_owner._velocity = Vector3()
	
	if _owner._dir_input != Vector2.ZERO:
		return State.PLAYER_WALK
		
	return -1