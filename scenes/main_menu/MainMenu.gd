extends Node2D

onready var _title:Label = $Title
onready var _start_button:Button = $Menu/StartButton
onready var _quit_button:Button = $Menu/QuitButton
onready var _fullscreen_checkbox:CheckBox = $Menu/FullscreenCheckbox
onready var _tutorial_checkbox:CheckBox = $Menu/TutorialCheckbox
onready var _music_volume_label = $Menu/MusicVolumeLabel
onready var _music_volume_slider = $Menu/MusicVolumeSlider
onready var _language_dropdown:OptionButton = $Menu/LanguageDropdown
onready var _input_device_dropdown:OptionButton = $Menu/InputDeviceDropdown

##
# @override
##
func _ready():
	_start_button.grab_focus()
	_start_button.connect("pressed", self, "_start_game")
	_quit_button.connect("pressed", self, "_quit_game")
	
	OS.window_fullscreen = Settings.fullscreen
	_fullscreen_checkbox.pressed = Settings.fullscreen
	_fullscreen_checkbox.connect("pressed", self, "_toggle_fullscreen")
	
	_tutorial_checkbox.pressed = Settings.tutorial_unabled
	_tutorial_checkbox.connect("pressed", self, "_toggle_tutorial")
	
	_music_volume_slider.value = Settings.music_volume
	_music_volume_slider.connect("value_changed", self, "_set_music_volume")
	
	# Set items of language drop down.
	var num_of_languages = Language.data.size()
	for i in num_of_languages:
		var language_data = Language.data[i]
		if !language_data.enabled:
			continue
		_language_dropdown.add_item(language_data.name, i)
	
	_language_dropdown.select(_language_dropdown.get_item_index(Settings.language))
	_language_dropdown.connect("item_selected", self, "_set_language")
	_set_language(Settings.language)
	
	_input_device_dropdown.connect("item_selected", self, "_set_input_device")
	
	MusicPlayer.auto_play_next = true
	MusicPlayer.set_volume(Settings.music_volume)
	MusicPlayer.attempt_next()

##
# @method _start_game
##
func _start_game():
	get_tree().change_scene("res://scenes/game/Game.tscn")

##
# @method _quit_game
##
func _quit_game():
	get_tree().quit()

##
# @method _toggle_fullscreen
##
func _toggle_fullscreen():
	OS.window_fullscreen = _fullscreen_checkbox.pressed
	Settings.fullscreen = OS.window_fullscreen
	
##
# @method _toggle_tutorial
##
func _toggle_tutorial():
	Settings.tutorial_unabled = _tutorial_checkbox.pressed
	
##
# @method _set_music_volume
# @param {float} volume
##
func _set_music_volume(volume:float):
	Settings.music_volume = volume
	MusicPlayer.set_volume(volume)
		
##
# @method _set_language
# @param {int} idx
##
func _set_language(idx:int):
	var id = _language_dropdown.get_item_id(idx)
	Settings.language = id
	TranslationServer.set_locale(Language.data[id].code)
	
	_title.text = tr("TITLE")
	_start_button.text = tr("START_GAME")
	_quit_button.text = tr("QUIT")
	_fullscreen_checkbox.text = tr("FULLSCREEN")
	_tutorial_checkbox.text = tr("TUTORIAL_ENABLE")
	_music_volume_label.text = tr("MUSIC_VOLUME")
	
	# Set items of input device drop down.
	_input_device_dropdown.clear()
	var num_of_devices = InputDevice.data.size()
	for i in num_of_devices:
		var device_data = InputDevice.data[i]
		if !device_data.enabled:
			continue
		_input_device_dropdown.add_item(tr(device_data.tr), i)
	
	_input_device_dropdown.select(_input_device_dropdown.get_item_index(Settings.input_device))
		
##
# @method _set_input_device
# @param {int} idx
##
func _set_input_device(idx:int):
	var id = _input_device_dropdown.get_item_id(idx)
	Settings.input_device = id