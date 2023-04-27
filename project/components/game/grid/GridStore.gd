extends Node


enum {
	TEST,
}


onready var data = {
	TEST: {
		"name": "Test",
		"grid": [
			[ CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1 ],
			[ CardStore.GRASS_1X2, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1 ],
			[ null, CardStore.GRASS_1X1, CardStore.GRASS_2X2, null, CardStore.GRASS_1X1, CardStore.GRASS_1X1 ],
			[ CardStore.GRASS_1X1, CardStore.GRASS_1X1, null, null, CardStore.GRASS_1X1, CardStore.GRASS_1X1 ],
			[ CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_2X1, null, CardStore.GRASS_1X1 ],
			[ CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1, CardStore.GRASS_1X1 ],
		]
	}
}
