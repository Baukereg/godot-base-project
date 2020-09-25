extends KinematicBody
class_name Player

const GRAVITY = Vector3.DOWN * 40
const WALK_SPEED = 8
const ROTATION_SPEED = 8

export(float) var movement_offset = 0

onready var _collision_shape = $CollisionShape
onready var _mesh = $Mesh
onready var _animation_player = $AnimationPlayer
onready var _state_machine:StateMachine = $StateMachine

var _velocity = Vector3()
var _dir_input:Vector2 = Vector2.ZERO

##
# @override
##
func _ready():
	_state_machine.set_state(State.PLAYER_IDLE)

##
# @override
##
func _physics_process(delta):
	_dir_input = UserInput.get_directional_input().rotated(movement_offset)
	
	_state_machine.process(delta)
	
	_velocity += GRAVITY * delta
	_velocity = move_and_slide(_velocity, Vector3.UP)
		