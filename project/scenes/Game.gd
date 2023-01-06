extends Node2D


onready var camera = $Camera
onready var player_controller = $PlayerController
onready var options_menu = $CanvasLayer/PauseMenu.options_menu


func _ready():
	randomize()
	
	_update_camera_smoothing_speed()
	options_menu.connect("camera_smoothing_speed_changed", self, "_update_camera_smoothing_speed")
	camera.target = player_controller
	
	
func _process(delta):
	# Just a hacky way to make a zoom level toggle for showing off.
	if Input.is_action_just_pressed("camera_zoom"):
		if camera.target_zoom == .4: camera.set_target_zoom(1)
		else: camera.set_target_zoom(.4)


func _update_camera_smoothing_speed():
	camera.set_camera_smoothing_speed(Settings.camera_smoothing_speed)
