extends Node


const WANDER_TIME = 2

var _direction:Vector2
var _timer:Timer


func start_state(actor_controller:ActorController):
	actor_controller.animation_player.play("walk")
	_direction = Vector2.ONE.rotated(deg2rad(randi() % 360))
	actor_controller.view.scale.x = -1 if _direction.x < 0 else 1
	
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_timer.connect("timeout", actor_controller, "set_state", [ActorController.State.IDLE])
	_timer.start(WANDER_TIME)


func process_state(actor_controller:ActorController, delta):
	actor_controller.move_and_slide(_direction * actor_controller.model.wander_speed)


func end_state(actor_controller:ActorController):
	_timer.queue_free()
