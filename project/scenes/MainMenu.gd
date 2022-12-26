extends Control


const AUDIO_CORRECTION = .4

onready var start_button = $CenterContainer/VBoxContainer/HBoxContainer/StartButton
onready var quit_button = $CenterContainer/VBoxContainer/HBoxContainer2/QuitButton
onready var tutorial_button = $CenterContainer/VBoxContainer/HBoxContainer2/TutorialButton

onready var options_menu = $CenterContainer/VBoxContainer/HBoxContainer/OptionsMenu
onready var quit_confirm_modal = $QuitConfirmModal

onready var credits_label = $CreditsLabel
onready var version_label = $VersionLabel


func _ready():
	get_tree().paused = false
	
	_update_locale()
	options_menu.connect("language_changed", self, "_update_locale")
	
	# Start music player.
	MusicPlayer.streams = [ Music.streams[Music.CHILL_OUT], Music.streams[Music.MASTER_OF_THE_FEAST] ]
	MusicPlayer.start()
	
	# Connect buttons.
	start_button.connect("pressed", self, "_start_game")
	start_button.grab_focus()
	quit_button.connect("pressed", quit_confirm_modal, "popup")
	tutorial_button.connect("pressed", self, "_start_tutorial")
	
	# Connect modals.
	quit_confirm_modal.no_button.connect("pressed", quit_button, "grab_focus")
	quit_confirm_modal.yes_button.connect("pressed", self, "_quit_game")
	
	if Settings.for_web:
		# No need in a web browser for a quit button.
		quit_button.hide()
	
	if Settings.dev_mode:
		options_menu.audio_slider.value = 0
		options_menu.music_slider.value = 0
		
		
func _update_locale():
	credits_label.text = tr("MAIN_MENU_CREDITS").replace("{AUTHOR}", Settings.AUTHOR)
	version_label.text = Settings.VERSION
	
	
func _start_game():
	var _error = get_tree().change_scene("res://scenes/Game.tscn")
	
	
func _start_tutorial():
	var _error = get_tree().change_scene("res://scenes/Tutorial.tscn")
	
	
func _quit_game():
	get_tree().quit()
