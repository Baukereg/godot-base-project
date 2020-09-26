extends StateInstance
class_name CameraStateOverShoulder

const LERP_SPEED = .06
const ROTATION_OFFSET:Vector3 = Vector3(0, deg2rad(-90), 0)

##
# @override
##
func _ready():
	if _owner.target != null:
		_owner.translation = _owner.target.translation
		_owner.rotation = _owner.target.rotation + ROTATION_OFFSET
		_owner.set_zoom_level(ZoomLevel.NORMAL, true)

##
# @override
##
func process(delta:float):
	if Input.is_action_just_released("ui_camera_state"):
		return State.CAMERA_FREE_FOLLOW
		
	if _owner.target != null:
		_owner.translation = lerp(_owner.translation, _owner.target.translation, LERP_SPEED)
		
		var towards_y = Utils.normalize_rotate_towards(_owner.rotation_degrees.y, _owner.target.rotation_degrees.y)
		var towards_vector = Vector3(_owner.target.rotation.x, deg2rad(towards_y), _owner.target.rotation.z)
		_owner.rotation = lerp(_owner.rotation, towards_vector + ROTATION_OFFSET, LERP_SPEED)
		
		_owner.emit_signal("camera_rotated", _owner.rotation.y)
	
	return -1