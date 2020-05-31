extends Spatial

onready var _title = $Title
onready var _cam_control = $CamControl
onready var _player = $Player

##
# @override
##
func _ready():
	_set_language(Settings.language)
	_title.text = tr("TITLE")
	_cam_control.target = _player
	
##
# @override
##
func _process(delta):
	if Input.is_action_just_released("ui_full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
##
# @method _set_language
# @param {int} id
##
func _set_language(id:int):
	Settings.language = id
	TranslationServer.set_locale(Language.data[id].code)