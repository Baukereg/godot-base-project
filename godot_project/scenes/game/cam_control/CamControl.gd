extends Spatial
class_name CamController
signal camera_rotated

const TARGET_LERP_SPEED = .1
const ROTATION_SPEED = deg2rad(1)
const ZOOM_SPEED = 1

onready var _camera:Camera = $Camera
onready var _tween:Tween = $Tween

var target = null
var zoom_level = 0

##
# @override
##
func _physics_process(delta):
	if target != null:
		translation = lerp(translation, target.translation, TARGET_LERP_SPEED)
	
	if Input.is_action_pressed("ui_rotate_clockwise"):
		rotate_y(-ROTATION_SPEED)
		emit_signal("camera_rotated", rotation.y)
	if Input.is_action_pressed("ui_rotate_anticlockwise"):
		rotate_y(ROTATION_SPEED)
		emit_signal("camera_rotated", rotation.y)
		
##
# @method set_zoom_level
# @param {int} id
# @param {bool} tween
##
func set_zoom_level(id:int, tween:bool = false):
	zoom_level = id
	var zoom_level_data = ZoomLevel.data[id]
	
	if !tween:
		_camera.translation = zoom_level_data.translation
		_camera.look_at(Vector3.ZERO, Vector3.UP);
	else:
		_tween.stop_all()
		_tween.interpolate_property(
			_camera, "translation",
			_camera.translation, zoom_level_data.translation, ZOOM_SPEED,
			Tween.TRANS_QUAD, Tween.EASE_OUT
		)
		_tween.start()