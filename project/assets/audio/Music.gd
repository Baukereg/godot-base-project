extends Node


enum {
	CHILL_OUT,
	MASTER_OF_THE_FEAST,
}

onready var streams = {
	CHILL_OUT: preload("res://assets/audio/music/chill-out.mp3"),
	MASTER_OF_THE_FEAST: preload("res://assets/audio/music/master-of-the-feast.mp3"),
}
