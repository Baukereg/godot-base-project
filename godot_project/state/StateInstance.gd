extends Node
class_name StateInstance

var _state_machine:StateMachine = null
var _owner = null

##
# @method initialize
# @param {Variant} owner
##
func initialize(state_machine:StateMachine, owner):
	_state_machine = state_machine
	_owner = owner

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
