extends TextureButton

@export var selection_border:Sprite2D
var descriptive_text:Label
var held_item:Globals.inventory_item = Globals.inventory_item.EMPTY

signal on_space_selected(item:Globals.inventory_item)

var is_held_item_empty:bool:
	get:
		return held_item == Globals.inventory_item.EMPTY

func _ready() -> void:
	descriptive_text = get_node("/root/Main/DescriptiveText")
		
	pressed.connect(_on_button_pressed)
	on_space_selected.connect(_set_selection_border_visible)


func _on_button_pressed():
	if is_held_item_empty:
		descriptive_text._update_text("There is no item in that slot")
		return
	
	print ("Current selected space: %s, self: %s" % [Globals.current_selected_inventory_space, self])
	
	if Globals.current_selected_inventory_space == self:
		_deselect_current_inventory_space()
		return
	
	#if Globals.current_selected_inventory_space == self:
		#_set_selection_border_invisible()
		#_remove_current_selected_space()
		#return	
	
	Globals.set_current_inventory_space(self)
	on_space_selected.emit(self)


func _update_sprite(new_sprite):
	texture_normal = new_sprite


func _deselect_current_inventory_space():
	_set_selection_border_invisible()
	Globals.set_current_inventory_space()
	print("Setting current inventory space to null")


func _set_selection_border_visible(item):
	selection_border.visible = true


func _set_selection_border_invisible():
	selection_border.visible = false
