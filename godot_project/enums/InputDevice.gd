extends Node

enum {
	MOUSE,
	KEYBOARD,
	MOUSE_KEYBOARD,
	JOYPAD
}

onready var data = [
	{
		"enabled": false,
		"tr": "INPUT_DEVICE_MOUSE"
	},
	{
		"enabled": true,
		"tr": "INPUT_DEVICE_KEYBOARD"
	},
	{
		"enabled": false,
		"tr": "INPUT_DEVICE_MOUSE_KEYBOARD"
	},
	{
		"enabled": true,
		"tr": "INPUT_DEVICE_JOYPAD"
	},
]