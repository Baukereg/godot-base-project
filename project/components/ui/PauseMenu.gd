extends Control
class_name PauseMenu


const IDLE_TIME = .4

onready var continue_button = $CenterContainer2/HBoxContainer/VBoxContainer/ContinueButton
onready var main_menu_button = $CenterContainer2/HBoxContainer/VBoxContainer/MainMenuButton
onready var quit_button = $CenterContainer2/HBoxContainer/VBoxContainer/QuitButton
onready var options_menu = $CenterContainer2/HBoxContainer/OptionsMenu

onready var main_menu_confirm_modal = $MainMenuConfirmModal
onready var quit_confirm_modal = $QuitConfirmModal

onready var _timer = $Timer


func _ready():
	hide()
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	# Connect buttons.
	continue_button.connect("pressed", self, "_continue")
	main_menu_button.connect("pressed", main_menu_confirm_modal, "popup")
	quit_button.connect("pressed", quit_confirm_modal, "popup")
	
	# Connect modals.
	main_menu_confirm_modal.no_button.connect("pressed", quit_button, "grab_focus")
	main_menu_confirm_modal.yes_button.connect("pressed", self, "_main_menu")
	quit_confirm_modal.no_button.connect("pressed", self, "_cancel_quit")
	quit_confirm_modal.yes_button.connect("pressed", self, "_quit_game")
	
	_timer.one_shot = true
	
	var _error = connect("visibility_changed", self, "_on_visibility_changed")
	
	if Settings.for_web:
		# No need in a web browser for a quit button.
		quit_button.hide()
	
	
func _process(_delta):
	if !visible && Input.is_action_just_pressed("pause"):
		_activate()
	elif Input.is_action_just_pressed("ui_cancel") && _timer.is_stopped():
		_continue()
	
	
func _activate():
	get_tree().paused = true
	_timer.start(IDLE_TIME)
	show()
	
	
func _continue():
	get_tree().paused = false
	hide()
	
	
func _main_menu():
	var _error = get_tree().change_scene("res://scenes/MainMenu.tscn")
	
	
func _quit_game():
	get_tree().quit()


func _on_visibility_changed():
	if is_visible_in_tree():
		continue_button.grab_focus()
