extends Control
class_name PauseMenu
signal continue_game

onready var _title:Label = $Title
onready var _continue_button:Button = $Menu/ContinueButton
onready var _main_menu_button:Button = $Menu/MainMenuButton
onready var _quit_button:Button = $Menu/QuitButton

##
# @override
##
func _ready():
	get_tree().paused = true
	
	_title.text = tr("PAUSE")
	
	_continue_button.grab_focus()
	_continue_button.text = tr("CONTINUE")
	_continue_button.connect("pressed", self, "_continue")
	
	_main_menu_button.text = tr("BACK_TO_MAIN_MENU")
	_main_menu_button.connect("pressed", self, "_back_to_main_menu")
	
	_quit_button.text = tr("QUIT")
	_quit_button.connect("pressed", self, "_quit_game")
	
##
# @method _continue
##
func _continue():
	get_tree().paused = false
	emit_signal("continue_game")

##
# @method _back_to_main_menu
##
func _back_to_main_menu():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/main_menu/MainMenu.tscn")

##
# @method _quit_game
##
func _quit_game():
	get_tree().quit()