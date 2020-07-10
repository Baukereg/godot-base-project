extends Spatial

onready var _title:Label = $Title
onready var _cam_control:CamController = $CamControl
onready var _player:Player = $Player

##
# @override
##
func _ready():
	_title.text = tr("TITLE")
	
	_cam_control.target = _player
	_cam_control.set_zoom_level(ZoomLevel.NORMAL)
	_cam_control.connect("camera_rotated", self, "_on_camera_rotated")
	
##
# @override
##
func _physics_process(delta):
	if Input.is_action_just_released("ui_full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_released("ui_zoom_level"):
		var next_zoom_level = _cam_control.zoom_level + 1
		if next_zoom_level >= ZoomLevel.data.size():
			next_zoom_level = 0
		_cam_control.set_zoom_level(next_zoom_level, true)
	
##
# @method _on_camera_rotated
##
func _on_camera_rotated(rotation):
	_player.movement_offset = -rotation