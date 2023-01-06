extends Node


func process_state(player_controller:PlayerController, delta):
	if Input.is_action_just_pressed("ui_up"):
		player_controller.set_state(PlayerController.State.LIFT_OFF)
		return
		
	if player_controller.input_vector != Vector2.ZERO:
		player_controller.set_state(PlayerController.State.WALK_INPUT)
