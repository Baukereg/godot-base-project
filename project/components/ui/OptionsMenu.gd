extends VBoxContainer
signal language_changed
signal camera_smoothing_speed_changed


const DEFAULT_LANGUAGE = "en"
const AUDIO_CORRECTION = .4

onready var _default_theme = preload("res://theme/default_theme.tres")
onready var _font_foundry_resource = preload("res://theme/fonts/font_foundry.tres")
onready var _font_dyslexic_resource = preload("res://theme/fonts/font_dyslexic.tres")

onready var language_option_button = $LanguageOptionButton
onready var fullscreen_button = $FullscreenButton
onready var dyslexic_button = $DyslexicButton
onready var smooth_camera_slider = $SmoothCameraSlider
onready var audio_slider:Slider = $AudioSlider
onready var audio_stream_player = $AudioStreamPlayer
onready var music_slider = $MusicSlider

var _is_dragging_audio = false


func _ready():
	# Set default states of input elements based on Settings.
	_change_language(TranslationServer.get_loaded_locales().find(DEFAULT_LANGUAGE))
	fullscreen_button.pressed = Settings.fullscreen
	dyslexic_button.pressed = Settings.dyslexic_font
	smooth_camera_slider.value = Settings.camera_smoothing_speed
	audio_slider.value = Settings.audio_volume
	music_slider.value = Settings.music_volume
	set_audio_volume(Settings.audio_volume)
	set_music_volume(Settings.music_volume)
	
	# Connect input elements.
	language_option_button.connect("item_selected", self, "_change_language")
	fullscreen_button.connect("pressed", self, "_toggle_fullscreen")
	dyslexic_button.connect("pressed", self, "_toggle_dyslexic_font")
	smooth_camera_slider.connect("value_changed", self, "_set_camera_smoothing_speed")
	audio_slider.connect("value_changed", self, "set_audio_volume", [ true ])
	audio_slider.connect("drag_started", self, "_start_audio_drag")
	audio_slider.connect("drag_ended", self, "_stop_audio_drag")
	audio_stream_player.connect("finished", self, "_loop_test_audio")
	music_slider.connect("value_changed", self, "set_music_volume")
	
	if Settings.for_web:
		# Itch.io offers its own control for fullscreen.
		fullscreen_button.hide()
	
		
func _change_language(i:int):
	Settings.language = TranslationServer.get_loaded_locales()[i]
	TranslationServer.set_locale(Settings.language)
	
	# Localize language option button.
	language_option_button.clear()
	for lang in TranslationServer.get_loaded_locales():
		language_option_button.add_item(tr("LANG_" + lang.to_upper()))
	language_option_button.select(i)
	
	emit_signal("language_changed")
	
	
func _toggle_fullscreen():
	OS.window_fullscreen = fullscreen_button.pressed
	Settings.fullscreen = OS.window_fullscreen
	
	
func _toggle_dyslexic_font():
	Settings.dyslexic_font = dyslexic_button.pressed
	if Settings.dyslexic_font:
		_default_theme.set_default_font(_font_dyslexic_resource)
	else:
		_default_theme.set_default_font(_font_foundry_resource)
	
	
func _set_camera_smoothing_speed(camera_smoothing_speed:float):
	Settings.camera_smoothing_speed = camera_smoothing_speed
	emit_signal("camera_smoothing_speed_changed")
		
		
func _start_audio_drag():
	_is_dragging_audio = true
	if !audio_stream_player.playing:
		audio_stream_player.play()
		

func _stop_audio_drag(value_changed):
	_is_dragging_audio = false
	

func _loop_test_audio():
	if _is_dragging_audio:
		audio_stream_player.play()
	
	
func set_audio_volume(volume:float, play_test_audio = false):
	Settings.audio_volume = volume
	volume = linear2db(volume)
	AudioFxPlayer.set_volume(volume)
	audio_stream_player.volume_db = volume
	if play_test_audio:
		audio_stream_player.play()
		
	
func set_music_volume(volume:float):
	Settings.music_volume = volume
	volume = linear2db(volume * AUDIO_CORRECTION)
	MusicPlayer.set_volume(volume)
