extends Node

enum {
	NORMAL,
	CLOSE_UP,
	OVERVIEW
}

onready var data = [
	{
		"name": "normal",
		"translation": Vector3(0, 7.5, 5),
		"rotation": Vector3(deg2rad(-55), 0, 0),
	},
	{
		"name": "close up",
		"translation": Vector3(0, 2.5, 3),
		"rotation": Vector3(deg2rad(-25), 0, 0),
	},
	{
		"name": "overview",
		"translation": Vector3(0, 13, 5),
		"rotation": Vector3(deg2rad(-70), 0, 0),
	},
]