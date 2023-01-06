extends Node2D
class_name PlanetController


onready var collision_shape_2d = $CollisionShape2D


export(float) var radius = 150
export(float) var gravity_range = 150
export(float) var gravity_max_strength:float = 3.0

# Derived state.
var circumference:float
var move_angle_ratio:float


func _ready():
	circumference =  PI * (2 * radius)
	move_angle_ratio = deg2rad(360 / circumference)
	
	collision_shape_2d.shape = collision_shape_2d.shape.duplicate()
	collision_shape_2d.shape.radius = radius + gravity_range


func _draw():
	draw_circle(Vector2.ZERO, radius, Color.cadetblue)
	

func get_gravity_strength(point:Vector2):
	var dist_to_surface = position.distance_to(point) - radius
	if dist_to_surface > gravity_range:
		return 0
	var ratio = 1 - (dist_to_surface / gravity_range)
	return gravity_max_strength * ratio


func get_dist_to_surface(point:Vector2):
	return position.distance_to(point) - radius
