extends Node

enum {
	CAMERA_FREE_FOLLOW,
	CAMERA_OVER_SHOULDER,
	PLAYER_IDLE,
	PLAYER_WALK
}

onready var data = [
	{
		"resource": preload("res://state/camera_state/CameraStateFreeFollow.gd")
	},
	{
		"resource": preload("res://state/camera_state/CameraStateOverShoulder.gd")
	},
	{
		"resource": preload("res://state/player_state/PlayerStateIdle.gd")
	},
	{
		"resource": preload("res://state/player_state/PlayerStateWalk.gd")
	}
]