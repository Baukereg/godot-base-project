extends Popup


onready var label = $CenterContainer2/HBoxContainer/Label
onready var no_button = $CenterContainer2/HBoxContainer/NoButton
onready var yes_button = $CenterContainer2/HBoxContainer/YesButton


export(String) var text = "YOU_SURE"
export(String) var no_text = "YOU_SURE_NO"
export(String) var yes_text = "YOU_SURE_YES"


func _ready():
	# Set texts.
	label.text = text
	no_button.text = no_text
	yes_button.text = yes_text
	
	# Connect buttons.
	no_button.connect("pressed", self, "deactivate")
	yes_button.connect("pressed", self, "deactivate")
	
	
func activate():
	no_button.grab_focus()
	show()
	
	
func deactivate():
	hide()
