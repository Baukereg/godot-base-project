extends Node


func process_state(player_controller:PlayerController, delta):
	if player_controller.input_vector == Vector2.ZERO:
		player_controller.set_state(PlayerController.State.IDLE)
		return
	
	if player_controller.input_vector.x == 0:
		return
		
	var dir:int = -1 if player_controller.input_vector.x < 0 else 1
	player_controller.view.scale.x = dir

	var angle_change = player_controller.planet.move_angle_ratio * (player_controller.model.walk_speed * dir * delta)
	var angle_from_planet:float = player_controller.position.angle_to_point(player_controller.planet.position) + angle_change
	player_controller.position = player_controller.planet.position + ((Vector2.RIGHT * player_controller.planet.radius).rotated(angle_from_planet))
	player_controller.rotation = player_controller.position.angle_to_point(player_controller.planet.position)
	
