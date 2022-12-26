extends Node


onready var _mouse_cursor_normal_resource = preload("res://assets/sprites/ui/mouse_cursor_normal.png")
onready var _mouse_cursor_active_resource = preload("res://assets/sprites/ui/mouse_cursor_active.png")


func _ready():
	Input.set_custom_mouse_cursor(_mouse_cursor_normal_resource)
	Input.set_custom_mouse_cursor(_mouse_cursor_active_resource, Input.CURSOR_POINTING_HAND)
