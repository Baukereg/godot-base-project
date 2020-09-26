extends Node
class_name StateInstance

var _state_machine:StateMachine = null
var _owner = null

##
# @override
##
func _ready():
	_state_machine = get_parent()
	_owner = _state_machine.get_parent()

##
# Should return a new state id should a transition to a new state be required,
# else a -1 to continue the state.
#
# @method process
# @param {float} delta
# @return {int} new state id
##
func process(delta:float):
	return -1
