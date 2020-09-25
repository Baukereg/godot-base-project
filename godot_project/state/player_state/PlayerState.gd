extends StateInstance
class_name PlayerState

var _collision_shape
var _mesh
var _animation_player

##
# @override
##
func _ready():
	_collision_shape = _owner._collision_shape
	_mesh = _owner._mesh
	_animation_player = _owner._animation_player