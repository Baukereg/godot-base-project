extends KinematicBody2D
class_name PlayerController


onready var _player_model_resource = preload("res://components/game/player/PlayerModel.gd")


enum State {
	IDLE,
	WALK_INPUT,
}

onready var states = {
	State.IDLE: $States/StateIdle,
	State.WALK_INPUT: $States/StateWalkInput
}

onready var view:Node2D = $View
onready var animation_player:AnimationPlayer = $View/AnimationPlayer

var _state_id:int = -1

var model:PlayerModel
var input_vector:Vector2


func _ready():
	if model == null:
		model = _player_model_resource.new()
	set_state(State.IDLE)


func _physics_process(delta):
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
	if states[_state_id].has_method("process_state"):
		states[_state_id].process_state(self, delta)
	
	
func set_state(state_id:int):
	if _state_id == state_id:
		return
	
	if _state_id != -1 && states[_state_id].has_method("end_state"):
		states[_state_id].end_state(self)
	
	_state_id = state_id
	if states[_state_id].has_method("start_state"):
		states[_state_id].start_state(self)
