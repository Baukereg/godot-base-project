extends Node


func start_state(player_controller:PlayerController):
	player_controller.rotation = player_controller.position.angle_to_point(player_controller.planet.position)
	player_controller.position = player_controller.planet.position + (Vector2.RIGHT * player_controller.planet.radius).rotated(player_controller.rotation)
	player_controller.set_state(PlayerController.State.IDLE)
