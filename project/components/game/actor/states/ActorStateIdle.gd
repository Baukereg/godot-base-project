extends Node


const IDLE_TIME = 5

var _timer:Timer


func start_state(actor_controller:ActorController):
	actor_controller.animation_player.play("idle")
	
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_timer.connect("timeout", self, "_on_wander", [actor_controller])
	_timer.start(IDLE_TIME)
	
	
func _on_wander(actor_controller:ActorController):
	actor_controller.set_state(ActorController.State.WANDER)


func end_state(actor_controller:ActorController):
	_timer.queue_free()
