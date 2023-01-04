extends Node


func start_state(player_controller:PlayerController):
	player_controller.animation_player.play("idle")


func process_state(player_controller:PlayerController, delta):
	if player_controller.input_vector != Vector2.ZERO:
		player_controller.set_state(PlayerController.State.WALK_INPUT)
