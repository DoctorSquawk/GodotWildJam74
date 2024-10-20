extends Node

var current_selected_inventory_space = null

enum inventory_item { EMPTY, KEY, THREAD, PRYBAR, SHEARS, PLIERS, EYE, ARMS }
@export var inventory_item_images:Array = []

var inventory_item_selected:bool:
	get:
		return current_selected_inventory_space != null


func _ready() -> void:
	_load_inventory_images()
	

func _load_inventory_images():
	for n in inventory_item:
		match inventory_item[n]:
			inventory_item.EMPTY:
				inventory_item_images.append(null)
			inventory_item.KEY:
				inventory_item_images.append(load("res://Assets/Visual Assets/InventoryItems/Key.png"))
			inventory_item.THREAD:
				inventory_item_images.append(load("res://Assets/Visual Assets/InventoryItems/Needle&Thread.png"))
			inventory_item.PRYBAR:
				inventory_item_images.append(load("res://Assets/Visual Assets/InventoryItems/Prybar.png"))
			inventory_item.SHEARS:
				inventory_item_images.append(load("res://Assets/Visual Assets/InventoryItems/GardenShears.png"))
			inventory_item.PLIERS:
				inventory_item_images.append(load("res://Assets/Visual Assets/InventoryItems/Pliers.png"))
			inventory_item.EYE:
				inventory_item_images.append(load("res://Assets/Visual Assets/InventoryItems/ButtonEye.png"))
			inventory_item.ARMS:
				inventory_item_images.append(load("res://Assets/Visual Assets/InventoryItems/Arms.png"))
				
