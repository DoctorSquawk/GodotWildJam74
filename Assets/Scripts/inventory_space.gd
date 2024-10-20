extends TextureButton

@export var selection_border:Sprite2D
var held_item:Globals.inventory_item = Globals.inventory_item.EMPTY

signal on_space_selected(item:Globals.inventory_item)
signal on_space_deselected

func _ready() -> void:
	pressed.connect(emit_button_pressed_signal)
	on_space_selected.connect(_set_selection_border_visibile)
	on_space_deselected.connect(_set_selection_border_invisibile)


func emit_button_pressed_signal():
	if Globals.current_selected_inventory_space == self:
		on_space_deselected.emit()
		#_set_selection_border_invisibile()
		return
	
	on_space_selected.emit(self)
	#_set_selection_border_visibile()


func _update_sprite(new_sprite):
	texture_normal = new_sprite


func manually_deselect():
	on_space_deselected.emit()


func _set_selection_border_visibile(item):
	selection_border.visible = true


func _set_selection_border_invisibile():
	selection_border.visible = false
