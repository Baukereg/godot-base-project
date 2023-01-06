extends Node


func process_state(player_controller:PlayerController, delta):
	# Gravity pull from planet.
	if player_controller.planet != null:
		var angle_to_planet:float = player_controller.planet.position.angle_to_point(player_controller.position)
		if angle_to_planet != player_controller.rotation:
			var gravity_strength:float = player_controller.planet.get_gravity_strength(player_controller.position)
			player_controller.rotation = lerp_angle(player_controller.rotation, angle_to_planet, gravity_strength * .01)
		
	# Flight.
	player_controller.translate(Vector2.RIGHT.rotated(player_controller.rotation) * player_controller.model.fly_speed * delta)
	
	# Check for landing.
	if player_controller.planet != null:
		var dist_to_planet:float = player_controller.planet.get_dist_to_surface(player_controller.position)
		if dist_to_planet < 0:
			player_controller.set_state(PlayerController.State.LANDING)
