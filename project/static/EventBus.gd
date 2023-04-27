extends Node


var events:Array
var global_data = {}


func _init():
	clearevents()
	
	
func clearevents():
	events = []
	for i in 30:
		events.append([])
		

func publish(event_type, data = {}):
	# Add event type to the event data.
	data.event_type = event_type
	
	# Publish to all subscriptions.
	for subscription in events[event_type]:
		subscription[0].call(subscription[1], data)
	

func subscribe(event_type, receiver, method_name):
	assert(receiver.has_method(method_name))	
	events[event_type].push_back([ receiver, method_name ])
	

func unsubscribe(event_type, receiver, method_name):
	for i in events[event_type].size():
		var subscription = events[event_type][i]
		if subscription[0] == receiver && subscription[1] == method_name:
			events[event_type].remove(i)
			return
