extends Node

const JOYPAD_TRESHHOLD = .2

##
# Return a Vector2 representing the current directional input.
# Will return a Vector2.ZERO in the case of no input.
#
# @method get_directional_input
# @public
# @return {Vector2} the directional input
##
func get_directional_input():
	var joy_x = Input.get_joy_axis(0, JOY_ANALOG_LX)
	var joy_y = Input.get_joy_axis(0, JOY_ANALOG_LY)
	if stepify(joy_x, JOYPAD_TRESHHOLD) || stepify(joy_y, JOYPAD_TRESHHOLD):
		return Vector2(joy_x, joy_y).normalized()
		
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	).normalized()