extends Node
class_name StateMachine

onready var _owner = get_parent()

var _state = null

##
# @method process
# @param {float} delta
##
func process(delta):
	if _state != null:
		var new_state_id = _state.process(delta)
		if new_state_id != -1:
			set_state(new_state_id)
	
##
# @method set_state
# @param {int} state_id
##
func set_state(state_id:int):
	if _state != null:
		remove_child(_state)
		_state.queue_free()
		_state = null
	
	var state_data = State.data[state_id]
	_state = state_data.resource.new()
	_state.initialize(self, _owner)
	add_child(_state)
	