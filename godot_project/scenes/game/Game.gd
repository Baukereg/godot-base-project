extends Spatial

onready var PAUSE_MENU_RESOURCE = preload("res://scenes/game/pause_menu/PauseMenu.tscn")

onready var _camera_instance = $CameraInstance
onready var _player = $Player

var _pause_menu = null

##
# @override
##
func _ready():
	# Set the default camera settings.
	_camera_instance.target = _player
	_camera_instance.set_zoom_level(ZoomLevel.NORMAL)
	_camera_instance.connect("camera_rotated", self, "_on_camera_rotated")
			
	Flags.subscribe(Flag.ON_INTERACTABLE, self, "_on_interactable")
	
##
# @override
##
func _exit_tree():
	Flags.unsubscribe(Flag.ON_INTERACTABLE, self, "_on_interactable")
	
##
# @override
##
func _physics_process(delta):
	if Input.is_action_just_released("ui_pause"):
		_open_pause_menu()
	
##
# @method _on_camera_rotated
# @param {float} camera_angle
##
func _on_camera_rotated(camera_angle:float):
	_player.movement_offset = -camera_angle
	
##
# @method _open_pause_menu
##
func _open_pause_menu():
	_pause_menu = PAUSE_MENU_RESOURCE.instance()
	add_child(_pause_menu)
	_pause_menu.connect("continue_game", self, "_on_pause_menu_close")
	
##
# @method _on_pause_menu_close
##
func _on_pause_menu_close():
	remove_child(_pause_menu)
	_pause_menu.queue_free()
	_pause_menu = null

func _on_interactable_entered(player):
	Flags.set_flag(Flag.ON_INTERACTABLE, true)

func _on_interactable_exited(player):
	Flags.set_flag(Flag.ON_INTERACTABLE, false)
	
func _on_interactable(value:bool):
	print_debug("interactable = " + str(value))
