extends Camera2D

signal camera_moved
signal camera_zoomed


const ZOOM_RANGE = Vector2(.6, 3)
const ZOOM_FACTOR = .2
const ZOOM_DURATION = .3
const DEFAULT_ZOOM = Vector2.ONE

onready var tween = $Tween

var zoom_level:float = DEFAULT_ZOOM.x setget _setzoom_level

var dragging:bool = false
var drag_position:Vector2


func _ready():
	zoom = DEFAULT_ZOOM


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			if event.is_pressed():
				dragging = true
				drag_position = get_viewport().get_mouse_position()
			else:
				dragging = false
				
	if event is InputEventMouseMotion and dragging:
		var global_mouse_position:Vector2 = get_viewport().get_mouse_position()
		var drag_delta:Vector2 = (global_mouse_position - drag_position) * zoom
		drag_position = global_mouse_position
		position -= drag_delta
		emit_signal("camera_moved")
	
	if event.is_action_pressed("zoom_in"):
		_setzoom_level(zoom_level - ZOOM_FACTOR)
		emit_signal("camera_zoomed")
	if event.is_action_pressed("zoom_out"):
		_setzoom_level(zoom_level + ZOOM_FACTOR)
		emit_signal("camera_zoomed")
		
		
func apply_zoom(dir:int):
	var value = zoom_level + ZOOM_FACTOR * dir
	_setzoom_level(value)


func _setzoom_level(value:float):
	zoom_level = clamp(value, ZOOM_RANGE.x, ZOOM_RANGE.y)
	
	tween.remove_all()
	tween.interpolate_property(self, "zoom",
		zoom, Vector2(zoom_level, zoom_level),
		ZOOM_DURATION * Engine.time_scale, Tween.TRANS_SINE, Tween.EASE_OUT
	)
	tween.start()
