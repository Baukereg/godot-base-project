extends Node2D
class_name GridComponent


const CARD_COMPONENT = preload("res://components/game/card/CardComponent.tscn")
const DIRECTIONS = [ Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT ]
const REVEAL_DELAY_INTVAL = .1

export var grid_id:int = -1

var grid_data:Dictionary

var card_components_by_grid_position:Dictionary
var active_card:CardComponent

var _drag = null
var _last_drag:Vector2 = Vector2.ZERO


func _ready():
	assert(grid_id != -1)
	grid_data = GridStore.data[grid_id]
	
	draw_cards()
	
	
func draw_cards():
	for card in get_children():
		card.queue_free()
		
	var grid:Array = grid_data.grid
	for j in grid.size():
		for i in grid[0].size():
			if grid[j][i] == null:
				continue
				
			var card_id:int = grid[j][i]
			var card_data:Dictionary = CardStore.data[card_id]
			
			var card:CardComponent = CARD_COMPONENT.instance()
			card.card_id = card_id
			card.grid_position = Vector2(i, j)
			add_child(card)
			card.connect("activated", self, "_card_activated")
			card.connect("deactivated", self, "_card_deactivated")
			
			# Fill card_components_by_grid_position.
			for ci in card_data.size.x:
				for cj in card_data.size.y:
					var grid_position:Vector2 = card.grid_position + Vector2(ci, cj)
					card_components_by_grid_position[grid_position] = card
	
	
func reveal_adjecent_cards(card:CardComponent):
	var other_cards:Array = get_adjecent_cards_of(card)
	var revealed_cards:int = 0
	for i in other_cards.size():
		var other_card:CardComponent = other_cards[i]
		if !other_card.is_revealed:
			other_card.reveal(true, revealed_cards * REVEAL_DELAY_INTVAL)
			revealed_cards += 1
	
	
func get_adjecent_cards_of(card:CardComponent):
	var output:Array
	
	for ci in card.card_data.size.x:
		for cj in card.card_data.size.y:
			var grid_query_position:Vector2 = card.grid_position + Vector2(ci, cj)
			for dir in DIRECTIONS:
				var other_grid_position:Vector2 = grid_query_position + dir
				if !card_components_by_grid_position.has(other_grid_position):
					continue
					
				var other_card:CardComponent = card_components_by_grid_position[other_grid_position]
				if other_card == card || output.has(other_card):
					continue
				
				output.push_back(other_card)
				
	return output
	
	
func deactivate_active_card():
	if active_card != null:
		active_card.deactivate()
	
	
func _card_activated(card:CardComponent):
	if active_card != card && active_card != null:
		active_card.deactivate()
	active_card = card
	reveal_adjecent_cards(active_card)
	
	
func _card_deactivated(card:CardComponent):
	if active_card == card:
		active_card = null
