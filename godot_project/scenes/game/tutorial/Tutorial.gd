extends Control
class_name Tutorial
signal tutorial_end

onready var _title:Label = $Title
onready var _text:Label = $Text
onready var _previous_button:Button = $Buttons/PreviousButton
onready var _close_button:Button = $Buttons/CloseButton
onready var _next_button:Button = $Buttons/NextButton

var _entries
var _num_of_entries:int
var _current_entry_idx:int

##
# @override
##
func _ready():
	get_tree().paused = true
	
	_previous_button.text = tr("PREVIOUS")
	_previous_button.connect("pressed", self, "_previous_entry")
	
	_close_button.text = tr("CLOSE")
	_close_button.connect("pressed", self, "_end_tutorial")
	
	_next_button.text = tr("NEXT")
	_next_button.connect("pressed", self, "_next_entry")

##
# @method initialize
# @param {Array} entry_ids
##
func initialize(entry_ids:Array):
	_entries = []
	for entry_id in entry_ids:
		_entries.push_back(TutorialEntry.data[entry_id])
	_num_of_entries = _entries.size()
	
	if _num_of_entries < 2:
		_previous_button.hide()
		_next_button.hide()
		_close_button.grab_focus()
	else:
		_next_button.grab_focus()
	
	_show_entry(0)
	
##
# @method _show_entry
# @param {int} idx
##
func _show_entry(idx:int):
	_current_entry_idx = idx
	var entry_data = _entries[idx]
	
	_title.text = tr(entry_data.title_tr)
	_text.text = tr(entry_data.text_tr)
	
	if _num_of_entries > 1:
		_previous_button.disabled = (_current_entry_idx == 0)
		_next_button.disabled = (_current_entry_idx == _num_of_entries - 1)
	
##
# @method _previous_entry
##
func _previous_entry():
	if _current_entry_idx > 0:
		_show_entry(_current_entry_idx - 1)
	
##
# @method _next_entry
##
func _next_entry():
	if _current_entry_idx < _num_of_entries - 1:
		_show_entry(_current_entry_idx + 1)
	
##
# @method _end_tutorial
##
func _end_tutorial():
	get_tree().paused = false
	emit_signal("tutorial_end")