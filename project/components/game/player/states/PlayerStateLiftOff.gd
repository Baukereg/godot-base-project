extends Node


const SPEED_LERP = .01
const SPEED_LERP_ACC = 1.05


var _speed:float = 0
var _max_speed:float
var _speed_lerp:float


func start_state(player_controller:PlayerController):
	_speed = 0
	_max_speed = player_controller.model.fly_speed
	_speed_lerp = SPEED_LERP
	
	player_controller.planet = null


func process_state(player_controller:PlayerController, delta):
	_speed = lerp(_speed, _max_speed, _speed_lerp)
	_speed_lerp = clamp(_speed_lerp * SPEED_LERP_ACC, 0, .9)
	player_controller.translate(Vector2.RIGHT.rotated(player_controller.rotation) * _speed * delta)
	
	if (_speed > _max_speed - 1):
		player_controller.set_state(PlayerController.State.IN_SPACE)
