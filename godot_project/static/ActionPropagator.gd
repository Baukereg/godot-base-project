extends Node

##
# @method send_action
# @param {Node} current_node
# @param {String} action_name
# @param {Object} data
# @return
##
func send_action(current_node:Node, action_name:String, data = {}):
	var method_name = "action_" + action_name
	
	while current_node != null:
		if current_node.has_method(method_name):
			return current_node.call(method_name, data)
		current_node = current_node.get_parent()
		
	return null