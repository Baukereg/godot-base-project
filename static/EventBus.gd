extends Node

var _events
var global_data = {}

##
# @override
##
func _init():
	clear_events()
	
##
# @method clear_events
##
func clear_events():
	_events = []
	for i in 30:
		_events.append([])

##
# @method publish
# @param {int} event_type
# @param {Object} data
##
func publish(event_type, data = {}):
	# Add event type to the event data.
	data.event_type = event_type
	
	# Add global data to the event data.
	var global_keys = global_data.keys()
	for key in global_keys:
		if !data.has(key):
			data[key] = global_data[key]
	
	# Publish to all subscriptions.
	for subscription in _events[event_type]:
		subscription[0].call(subscription[1], data)
	
##
# @method subscribe
# @param {int} event_type
# @param {Variant} receiver
# @param {string} method_name
##
func subscribe(event_type, receiver, method_name):
	if !receiver.has_method(method_name):
		printerr(receiver, " doesn't have method ", method_name)
		return
		
	_events[event_type].push_back([ receiver, method_name ])
	
##
# @method unsubscribe
# @param {int} event_type
# @param {Variant} receiver
# @param {string} method_name
##
func unsubscribe(event_type, receiver, method_name):
	for i in _events[event_type].size():
		var subscription = _events[event_type][i]
		if subscription[0] == receiver && subscription[1] == method_name:
			_events[event_type].remove(i)
			return
