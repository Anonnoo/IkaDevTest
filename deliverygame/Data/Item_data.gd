extends Node

const items = [
	{ "id": 0, "name": "Red Mushroom", "texture": preload("res://Asset/Items/Red.png")},
	{ "id": 1, "name": "Green Mushroom", "texture": preload("res://Asset/Items/Green.png")},
	{ "id": 2, "name": "Yellow Mushroom", "texture": preload("res://Asset/Items/Yellow.png")},
	{ "id": 3, "name": "Purple Mushroom", "texture": preload("res://Asset/Items/Purple.png")}
]

func get_randomize_item():
	return items[randi() % items.size()]
