extends Node2D
class_name CardComponent

signal activated
signal deactivated


const CARD_SIZE = Vector2(120, 120)
const GAP = Vector2(16, 16)
const REVEAL_TIME = .2
const HIGHLIGHT_SCALE = Vector2(1.05, 1.05)
const HOVER_TIME = .1
const BLUR_TIME = .2

const VIEW_POSITION_CORRECTION = {
	Vector2.ONE: Vector2.ZERO,
	Vector2(1, 2): Vector2(0, .5),
	Vector2(2, 1): Vector2(.5, 0),
	Vector2(2, 2): Vector2(.5, .5),
}

const BACKS = {
	Vector2.ONE: preload("res://components/game/card/backs/Back1x1.tscn"),
	Vector2(1, 2): preload("res://components/game/card/backs/Back1x2.tscn"),
	Vector2(2, 1): preload("res://components/game/card/backs/Back2x1.tscn"),
	Vector2(2, 2): preload("res://components/game/card/backs/Back2x2.tscn"),
}

onready var card_container = $CardContainer
onready var reveal_tween = $RevealTween
onready var scale_tween = $ScaleTween

export var card_id:int = -1
export var grid_position:Vector2 = Vector2(-1, -1)

var card_data:Dictionary
var is_revealed:bool = false
var is_active:bool = false

var back:Node2D
var front:Node2D
var button:Button


func _ready():
	assert(card_id != -1)
	assert(grid_position != Vector2(-1, -1))
	
	card_data = CardStore.data[card_id]
	position = grid_position * (CARD_SIZE + GAP) + (CARD_SIZE * .5)
	
	card_container.position = VIEW_POSITION_CORRECTION[card_data.size] * (CARD_SIZE + GAP)
	
	back = BACKS[card_data.size].instance()
	card_container.add_child(back)
	
	front = card_data.front.instance()
	front.scale = Vector2(1, 0)
	card_container.add_child(front)
	
	button = Button.new()
	button.modulate.a = 0
	button.rect_size = (card_data.size * CARD_SIZE) + (VIEW_POSITION_CORRECTION[card_data.size] * 2 * GAP)
	button.rect_position = -CARD_SIZE * .5
	add_child(button)
	button.connect("mouse_entered", self, "_hover")
	button.connect("mouse_exited", self, "_blur")
	button.connect("pressed", self, "_pressed")
	button.hide()
	
	
func reveal(do_tween:bool = false, delay:float = 0):
	if is_revealed:
		return
		
	if !do_tween:
		back.hide()
		front.scale = Vector2.ONE
		button.show()
		is_revealed = true
		return
		
	reveal_tween.interpolate_property(back, "scale", Vector2.ONE, Vector2(1, 0), REVEAL_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay)
	reveal_tween.interpolate_property(front, "scale", Vector2(1, 0), Vector2.ONE, REVEAL_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay + REVEAL_TIME)
	reveal_tween.start()
	reveal_tween.connect("tween_all_completed", self, "_reveal_tween_completed")
	
	
func _reveal_tween_completed():
	button.show()
	is_revealed = true
	
	
func _hover():
	z_index = 1
	scale_tween.remove_all()
	scale_tween.interpolate_property(card_container, "scale", card_container.scale, HIGHLIGHT_SCALE, HOVER_TIME)
	scale_tween.start()
	
	
func _blur():
	if is_active:
		return
		
	z_index = 0
	scale_tween.remove_all()
	scale_tween.interpolate_property(card_container, "scale", card_container.scale, Vector2.ONE, BLUR_TIME)
	scale_tween.start()
	
	
func _pressed():
	if is_revealed:
		activate()
		
		
func activate():
	if is_active == false:
		is_active = true
		emit_signal("activated", self)
		
		
func deactivate():
	if is_active == true:
		is_active = false
		_blur()
		emit_signal("deactivated", self)
