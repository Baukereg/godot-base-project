extends Node2D


const ACTIVE_CARD_TRESHOLD = 1.5

onready var grid_component = $GridComponent
onready var camera = $Camera


func _ready():
	var start_card:CardComponent = grid_component.card_components_by_grid_position[Vector2(2, 2)]
	start_card.reveal()
	
	camera.position = start_card.position + start_card.card_container.position
	camera.connect("camera_zoomed", self, "_camera_zoomed")
	
	
func _camera_zoomed():
	if camera.zoom_level > ACTIVE_CARD_TRESHOLD:
		grid_component.deactivate_active_card()
