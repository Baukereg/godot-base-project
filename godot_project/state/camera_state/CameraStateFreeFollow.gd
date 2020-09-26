extends StateInstance
class_name CameraStateFreeFollow

const LERP_SPEED = .1
const ROTATION_SPEED = deg2rad(2)

##
# @override
##
func _ready():
	if _owner.target != null:
		_owner.translation = _owner.target.translation
		_owner.rotation.x = 0
		_owner.rotation.z = 0
		_owner.emit_signal("camera_rotated", _owner.rotation.y)

##
# @override
##
func process(delta:float):
	_owner._process_zoom_level_input()
	if Input.is_action_just_released("ui_camera_state"):
		return State.CAMERA_OVER_SHOULDER
	
	if _owner.target != null:
		_owner.translation = lerp(_owner.translation, _owner.target.translation, LERP_SPEED)
	
	if Input.is_action_pressed("ui_rotate_clockwise"):
		_owner.rotate_y(-ROTATION_SPEED)
		_owner.emit_signal("camera_rotated", _owner.rotation.y)
	if Input.is_action_pressed("ui_rotate_anticlockwise"):
		_owner.rotate_y(ROTATION_SPEED)
		_owner.emit_signal("camera_rotated", _owner.rotation.y)
	
	return -1