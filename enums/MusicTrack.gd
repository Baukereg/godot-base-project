extends Node

enum {
	AQUARIUM,
	BLIPPY_TRANCE
}

onready var data = [
	{
		"name": "Aquarium",
		"author": "Kevin MacLeod",
		"resource": preload("res://assets/audio/music/aquarium.ogg")
	},
	{
		"name": "Blippy Trance",
		"author": "Kevin MacLeod",
		"resource": preload("res://assets/audio/music/blippy-trance.ogg")
	},
]