extends Node

enum {
	PLAYER_IDLE,
	PLAYER_WALK
}

onready var data = [
	{
		"resource": preload("res://state/player_state/PlayerStateIdle.gd")
	},
	{
		"resource": preload("res://state/player_state/PlayerStateWalk.gd")
	}
]