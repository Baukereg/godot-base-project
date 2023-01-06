extends KinematicBody2D
class_name ActorController


onready var ACTOR_MODEL_RESOURCE = preload("res://components/game/actor/ActorModel.gd")


enum State {
	IDLE,
	WANDER,
}

onready var states = {
	State.IDLE: $States/StateIdle,
	State.WANDER: $States/StateWander
}

onready var view:Node2D = $View
onready var animation_player:AnimationPlayer = $View/AnimationPlayer

var model:ActorModel

var _state_id:int = -1


func _ready():
	if model == null:
		model = ACTOR_MODEL_RESOURCE.new()
	set_state(State.IDLE)


func _physics_process(delta):
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
