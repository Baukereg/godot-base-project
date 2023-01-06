extends Area2D
class_name PlayerController


onready var _player_model_resource = preload("res://components/game/player/PlayerModel.gd")


const ROTATION_OFFSET = deg2rad(-90)

enum State {
	IN_SPACE,
	LANDING,
	IDLE,
	WALK_INPUT,
	LIFT_OFF,
}

onready var states = {
	State.IN_SPACE: $States/InSpace,
	State.LANDING: $States/Landing,
	State.IDLE: $States/Idle,
	State.WALK_INPUT: $States/WalkInput,
	State.LIFT_OFF: $States/LiftOff,
}

onready var view:Node2D = $View
onready var animation_player:AnimationPlayer = $View/AnimationPlayer

var _state_id:int = -1

var model:PlayerModel
var input_vector:Vector2
var planet:PlanetController


func _ready():
	if model == null:
		model = _player_model_resource.new()
	
	connect("area_entered", self, "_on_planet_range_entered")
	connect("area_exited", self, "_on_planet_range_exited")
	
	set_state(State.IN_SPACE)


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


func _on_planet_range_entered(_planet):
	planet = _planet


func _on_planet_range_exited(_planet):
	planet = null
