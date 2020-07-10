extends Spatial

onready var TUTORIAL_RESOURCE = preload("res://scenes/game/tutorial/Tutorial.tscn")

onready var _cam_control:CamController = $CamControl
onready var _player:Player = $Player

var _tutorial:Tutorial = null

##
# @override
##
func _ready():
	# Set the default camera settings.
	_cam_control.target = _player
	_cam_control.set_zoom_level(ZoomLevel.NORMAL)
	_cam_control.connect("camera_rotated", self, "_on_camera_rotated")
	
	# Display the tutorial if enabled.
	if Settings.tutorial_unabled:
		if Settings.input_device == InputDevice.KEYBOARD:
			_start_tutorial([TutorialEntry.BASICS_KEYBOARD, TutorialEntry.HAVE_FUN])
		elif Settings.input_device == InputDevice.JOYPAD:
			_start_tutorial([TutorialEntry.BASICS_JOYPAD, TutorialEntry.HAVE_FUN])
	
##
# @override
##
func _physics_process(delta):
	if Input.is_action_just_released("ui_zoom_level"):
		var next_zoom_level = _cam_control.zoom_level + 1
		if next_zoom_level >= ZoomLevel.data.size():
			next_zoom_level = 0
		_cam_control.set_zoom_level(next_zoom_level, true)
		
##
# @method _start_tutorial
# @param {Array} entry_ids
##
func _start_tutorial(entry_ids:Array):
	_tutorial = TUTORIAL_RESOURCE.instance()
	add_child(_tutorial)
	_tutorial.initialize(entry_ids)
	_tutorial.connect("tutorial_end", self, "_on_tutorial_end")
	get_tree().paused = true
		
##
# @method _on_tutorial_end
##
func _on_tutorial_end():
	remove_child(_tutorial)
	_tutorial.queue_free()
	_tutorial = null
	get_tree().paused = false
	
##
# @method _on_camera_rotated
# @param {float} camera_angle
##
func _on_camera_rotated(camera_angle:float):
	_player.movement_offset = -camera_angle