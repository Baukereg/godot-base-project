extends Node


func start_state(player_controller:PlayerController):
	player_controller.animation_player.play("walk")


func process_state(player_controller:PlayerController, delta):
	if player_controller.input_vector == Vector2.ZERO:
		player_controller.set_state(PlayerController.State.IDLE)
		return
	
	if player_controller.input_vector.x != 0:
		player_controller.view.scale.x = -1 if player_controller.input_vector.x < 0 else 1
	player_controller.move_and_slide(player_controller.input_vector * player_controller.model.walk_speed)
