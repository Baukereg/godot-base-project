extends Node


enum {
	GRASS_1X1,
	GRASS_2X1,
	GRASS_1X2,
	GRASS_2X2,
}

onready var data = {
	GRASS_1X1: {
		"name": "Grass",
		"front": preload("res://components/game/card/fronts/CardGrass1x1.tscn"),
		"size": Vector2(1, 1),
	},
	GRASS_2X1: {
		"name": "Grass",
		"front": preload("res://components/game/card/fronts/CardGrass2x1.tscn"),
		"size": Vector2(2, 1),
	},
	GRASS_1X2: {
		"name": "Grass",
		"front": preload("res://components/game/card/fronts/CardGrass1x2.tscn"),
		"size": Vector2(1, 2),
	},
	GRASS_2X2: {
		"name": "Grass",
		"front": preload("res://components/game/card/fronts/CardGrass2x2.tscn"),
		"size": Vector2(2, 2),
	},
}
