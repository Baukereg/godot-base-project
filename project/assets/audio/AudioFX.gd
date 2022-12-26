extends Node


enum {
	TEST,
	BUTTON_CALL_TO_ACTION,
	BUTTON_HOVER,
	CONFIRM_CONFIRM,
	CONFIRM_CANCEL,
}

onready var streams = {
	TEST: preload("res://assets/audio/sfx/dice_throw_00.mp3"),
	BUTTON_CALL_TO_ACTION: preload("res://assets/audio/sfx/button_call_to_action.wav"),
	BUTTON_HOVER: preload("res://assets/audio/sfx/button_hover.wav"),
	CONFIRM_CONFIRM: preload("res://assets/audio/sfx/confirm_confirm.wav"),
	CONFIRM_CANCEL: preload("res://assets/audio/sfx/confirm_cancel.wav"),
}
