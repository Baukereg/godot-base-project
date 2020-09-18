extends Node

enum {
	NORMAL,
	CLOSE_UP,
	OVERVIEW
}

onready var data = [
	{
		"name": "normal",
		"translation": Vector3(0, 12, 12),
	},
	{
		"name": "close up",
		"translation": Vector3(0, 6, 6),
	},
	{
		"name": "overview",
		"translation": Vector3(0, 26, 26),
	},
]