extends Spatial
class_name CamController

var target = null

##
# @override
##
func _physics_process(delta):
	if target != null:
		translation = lerp(translation, target.translation, .1)