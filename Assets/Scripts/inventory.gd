extends Control

@export var max_spaces:int
@export var test_inventory:PackedScene
@export var sewing_kit:Node
@export var toolbox:Node
@export var box:Node
@export var drawer:Node
@export var bag:Node
@export var chest:Node
@export var doll:Node

var inventory_spaces:Array
const WHITESPACE_WIDTH:float = 50.0

func _ready() -> void:
	_format_inventory_spaces()
	
	inventory_spaces[0].held_item = Globals.inventory_item.KEY
	_update_inventory_visuals()
	
	print("Type of inventory item is %s" % typeof(inventory_spaces[0]))
	
	sewing_kit.on_object_opened.connect(_on_sewing_kit_opened)
	sewing_kit.item_not_used.connect(deselect_inventory_space)
	
	toolbox.on_object_opened.connect(_on_toolbox_opened)
	toolbox.item_not_used.connect(deselect_inventory_space)
	
	box.on_object_opened.connect(_on_box_opened)
	box.item_not_used.connect(deselect_inventory_space)
	
	drawer.on_object_opened.connect(_on_drawer_opened)
	drawer.item_not_used.connect(deselect_inventory_space)
	
	chest.on_object_opened.connect(_on_chest_opened)
	chest.item_not_used.connect(deselect_inventory_space)
	
	bag.on_object_opened.connect(_on_bag_opened)
	bag.item_not_used.connect(deselect_inventory_space)
	
	doll.on_arms_set.connect(_on_arms_set)
	doll.on_arms_repaired.connect(_on_arms_repaired)
	doll.on_eye_set.connect(_on_eye_set)
	doll.on_eye_repaired.connect(_on_eye_repaired)
	doll.on_stake_removed.connect(_on_stake_removed)
	doll.on_stake_repaired.connect(_on_stake_repaired)
	doll.item_not_used.connect(deselect_inventory_space)


func _format_inventory_spaces():
	if max_spaces > 0:
		inventory_spaces = []
		
		for i in max_spaces:
			var temp:TextureButton = test_inventory.instantiate()
			add_child(temp)
			
			temp.held_item = Globals.inventory_item.EMPTY
			temp.global_position.x = global_position.x #+ (temp.size.x * i) + (WHITESPACE_WIDTH * i)
			temp.global_position.y = global_position.y + (temp.size.y * i) + (WHITESPACE_WIDTH * i)
			temp.on_space_selected.connect(select_inventory_space)
			temp.on_space_deselected.connect(deselect_inventory_space)
			
			inventory_spaces.append(temp)
			
			print("Node %s is at position %s" % [i, temp.global_position])
		print(inventory_spaces.size())
	else:
		print("No inventory spaces in array")
		pass


func select_inventory_space(space):
	if space.held_item == null:
		print("No item in this slot")
		return
	
	print("Inventory space selected with " + str(space.held_item))
	Globals.current_selected_inventory_space = space
	
	for n in inventory_spaces.size():
		print("Is space %s equal to space %s?: %s" % [inventory_spaces[n], space, inventory_spaces[n] == space])
		
		if inventory_spaces[n] != space:
			inventory_spaces[n].manually_deselect()


func deselect_inventory_space():
	Globals.current_selected_inventory_space = null
	print("Deselecting inventory space")


func _on_sewing_kit_opened():
	if _add_item_to_inventory(Globals.inventory_item.THREAD):
		sewing_kit._set_open()
	else:
		return
	
	_update_inventory_visuals()
	_print_inventory()


func _on_toolbox_opened():
	_remove_inventory_item()
	
	if _add_item_to_inventory(Globals.inventory_item.PRYBAR):
		toolbox._set_open()
	else:
		return
	
	_update_inventory_visuals()
	_print_inventory()


func _on_box_opened():
	if drawer.is_opened:
		print("The prybar has broken")
		_remove_inventory_item()

	if _add_item_to_inventory(Globals.inventory_item.SHEARS):
		box._set_open()
	else:
		return

	_update_inventory_visuals()
	_print_inventory()


func _on_drawer_opened():
	if box.is_opened:
		print("The prybar has broken")
		_remove_inventory_item()
		
	if _add_item_to_inventory(Globals.inventory_item.EYE):
		drawer._set_open()
	else:
		return

	_update_inventory_visuals()
	_print_inventory()


func _on_chest_opened():
	if bag.is_opened:
		print("The shears get snagged and fall apart")
		_remove_inventory_item()
	
	if _add_item_to_inventory(Globals.inventory_item.PLIERS):
		chest._set_open()
	else:
		return
	
	_update_inventory_visuals()
	_print_inventory()


func _on_bag_opened():
	if chest.is_opened:
		print("The shears bend and the pin comes loose on the last strap")
		_remove_inventory_item()
	
	if _add_item_to_inventory(Globals.inventory_item.ARMS):
		bag._set_open()
	else:
		return
	
	_update_inventory_visuals()
	_print_inventory()


func _on_arms_set():
	_remove_inventory_item()
	_update_inventory_visuals()
	_print_inventory()


func _on_arms_repaired():
	if doll.eye_repaired and doll.stake_repaired:
		_remove_inventory_item()
	
	_update_inventory_visuals()
	_print_inventory()


func _on_eye_set():
	_remove_inventory_item()
	_update_inventory_visuals()
	_print_inventory()


func _on_eye_repaired():
	if doll.arms_repaired and doll.stake_repaired:
		_remove_inventory_item()
	
	_update_inventory_visuals()
	_print_inventory()


func _on_stake_removed():
	_remove_inventory_item()
	_update_inventory_visuals()
	_print_inventory()


func _on_stake_repaired():
	if doll.eye_repaired and doll.arms_repaired:
		_remove_inventory_item()
	
	_update_inventory_visuals()
	_print_inventory()


func _add_item_to_inventory(item:Globals.inventory_item) -> bool:
	var empty_space:Object = _find_empty_inventory_space()
	
	if (empty_space == null):
		print("Inventory has been filled but another object is trying to be added. Might need to increase the max space.")
		return false
	
	empty_space.held_item = item
	return true


func _find_empty_inventory_space() -> Object:
	for n in inventory_spaces.size():
		if inventory_spaces[n].held_item == Globals.inventory_item.EMPTY:
			return inventory_spaces[n]
	
	return null


func _remove_inventory_item():
	var space = Globals.current_selected_inventory_space
	space.held_item = Globals.inventory_item.EMPTY
	Globals.current_selected_inventory_space = null
	_update_inventory_visuals()


func _update_inventory_visuals():
	for n in inventory_spaces.size():
		var space = inventory_spaces[n]
		
		if inventory_spaces[n].held_item == Globals.inventory_item.EMPTY:
			space._update_sprite(null)
			continue
		
		var inventory_item = space.held_item
		var image = Globals.inventory_item_images[inventory_item]
		
		space._update_sprite(image)


func _print_inventory():
	var output:String = ""
	
	for n in inventory_spaces.size():
		output += str(inventory_spaces[n].held_item) + ", "
		
	print(output)
