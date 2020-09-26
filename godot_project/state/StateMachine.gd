extends Node
class_name StateMachine

var _state_id = -1
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
	
	_state_id = state_id
	var state_data = State.data[_state_id]
	_state = state_data.resource.new()
	add_child(_state)
	