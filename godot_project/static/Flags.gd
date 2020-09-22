extends Node

var _flags:Array
var _listeners:Array
var global_data = {}

##
# @override
##
func _init():
	_flags = []
	_listeners = []
	
##
# @method set_flag
# #param {int} flag_id
# #param {bool} value
##
func set_flag(flag_id:int, value:bool):
	while _flags.size() <= flag_id:
		_flags.append(false)
	
	_flags[flag_id] = value
	_publish_flag(flag_id)
	
##
# @method toggle_flag
# #param {int} flag_id
##
func toggle_flag(flag_id:int):
	while _flags.size() < flag_id:
		_flags.append(false)
	
	_flags[flag_id] = !_flags[flag_id]
	_publish_flag(flag_id)
	
##
# @method subscribe
# @param {int} flag_id
# @param {Variant} receiver
# @param {string} method_name
##
func subscribe(flag_id:int, receiver, method_name:String):
	if !receiver.has_method(method_name):
		printerr(receiver, " doesn't have method ", method_name)
		return
		
	while _listeners.size() <= flag_id:
		_listeners.append([])
		
	_listeners[flag_id].push_back([ receiver, method_name ])
	
##
# @method unsubscribe
# @param {int} flag_id
# @param {Variant} receiver
# @param {string} method_name
##
func unsubscribe(flag_id:int, receiver, method_name:String):
	for i in _listeners[flag_id].size():
		var subscription = _listeners[flag_id][i]
		if subscription[0] == receiver && subscription[1] == method_name:
			_listeners[flag_id].remove(i)
			return
			
##
# @method _publish_flag
# @param {int} flag_id
##
func _publish_flag(flag_id:int):
	if flag_id > (_listeners.size() - 1):
		return
	
	var subscriptions = _listeners[flag_id]
	for subscription in subscriptions:
		subscription[0].call(subscription[1], _flags[flag_id])
