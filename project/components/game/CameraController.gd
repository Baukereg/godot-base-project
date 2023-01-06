extends Camera2D
class_name CameraController


const CAMERA_SMOOTHING_RANGE = Vector2(1.0, 10.0)
const CAMERA_ZOOM_LERP_MULTIPLIER = .2


var target:Node2D
var target_smoothing_speed:float = .5
var target_zoom:float = 1
var target_zoom_lerp:float = 1
	
	
func _process(delta):
	if target != null:
		position = target.position
		
	if zoom.x != target_zoom:
		zoom.x = lerp(zoom.x, target_zoom, target_zoom_lerp * CAMERA_ZOOM_LERP_MULTIPLIER)
		zoom.y = lerp(zoom.y, target_zoom, target_zoom_lerp * CAMERA_ZOOM_LERP_MULTIPLIER)
		

func set_camera_smoothing_speed(value:float):
	target_smoothing_speed = value
	smoothing_speed = CAMERA_SMOOTHING_RANGE.y - (CAMERA_SMOOTHING_RANGE.y - CAMERA_SMOOTHING_RANGE.x) * value
	target_zoom_lerp = 1.0 - (value * .9)


func set_target_zoom(_target_zoom:float):
	target_zoom = _target_zoom
	
	if target_zoom_lerp == 1:
		zoom.x = target_zoom
		zoom.y = target_zoom
