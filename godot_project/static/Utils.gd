extends Node

##
# Pick a random integer within the given range.
#
# @method irand_range
# @param {int} value_min the minimum value
# @param {int} value_max the maximum value
# @return {int} random integer between the minimum and maximum value
##
func irand_range(value_min:int, value_max:int) -> int:
	return int(round(rand_range(value_min - .49, value_max + .49)))

##
# Choose a random value from the given array.
#
# @method choose
# @param {Array} values the values to choose from
# @return a random value
##
func choose(values:Array):
	return values[irand_range(0, values.size() - 1)]

##
# Random chance.
#
# @method chance
# @param {float} percentage a float value between 0 and 1
# @return {bool}
##
func chance(percentage:float) -> bool:
	return (randf() <= percentage)
	
##
# @method create_preset_array
# @param {int} size
# @param {*} default_value
# @return {Array}
##
func create_preset_array(size:int, default_value) -> Array:
	var arr = []
	for i in size:
		arr.append(default_value)
	return arr
	
##
# @method angle_to_vector2
# @param {float} angle
# https://godotengine.org/qa/9791/how-to-convert-a-radial-into-a-vector2
##
func angle_to_vector2(angle:float):
	return Vector2(cos(angle), sin(angle))
	
##
# @method vector3_deg2rad
# @param {Vector3} vec
# @return {Vector3}
##
func vector3_deg2rad(vec:Vector3):
	return Vector3(deg2rad(vec.x), deg2rad(vec.y), deg2rad(vec.z))
	
##
#
##
func normalize_rotate_towards(from:float, to:float, is_radians:bool = false):
	var towards = to
	
	if is_radians:
		from = rad2deg(towards)
		towards = rad2deg(towards)
	
	while abs(from - towards) > 180:
		if towards > from:
			towards -= 360
		else:
			towards += 360
			
	if is_radians:
		return deg2rad(towards)
			
	return towards