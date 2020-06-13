extends Node2D

onready var _start_button = $Menu/StartButton
onready var _quit_button = $Menu/QuitButton
onready var _fullscreen_checkbox = $Menu/FullscreenCheckbox

##
# @override
##
func _ready():
	_start_button.grab_focus()
	_start_button.connect("pressed", self, "_start_game")
	_quit_button.connect("pressed", self, "_quit_game")
	_fullscreen_checkbox.connect("pressed", self, "_toggle_fullscreen")

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