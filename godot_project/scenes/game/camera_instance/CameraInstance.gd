extends Spatial
class_name CameraInstance
signal camera_rotated

const ZOOM_SPEED = 1

onready var _camera:Camera = $Camera
onready var _tween:Tween = $Tween
onready var _state_machine:StateMachine = $StateMachine

var target = null
var zoom_level = 0

##
# @override
##
func _ready():
	set_zoom_level(ZoomLevel.NORMAL)
	_state_machine.set_state(State.CAMERA_FREE_FOLLOW)

##
# @override
##
func _physics_process(delta):
	_state_machine.process(delta)
		
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
		
##
# @method _process_zoom_level_input
##
func _process_zoom_level_input():
	if Input.is_action_just_released("ui_zoom_level"):
		var next_zoom_level = zoom_level + 1
		if next_zoom_level >= ZoomLevel.data.size():
			next_zoom_level = 0
		set_zoom_level(next_zoom_level, true)
		