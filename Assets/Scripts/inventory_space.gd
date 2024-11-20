extends TextureButton

@export var selection_border:Sprite2D
var descriptive_text:Label
var held_item:Globals.inventory_item = Globals.inventory_item.EMPTY

signal on_space_clicked(space:Object)

var is_held_item_empty:bool:
	get:
		return held_item == Globals.inventory_item.EMPTY


func _ready() -> void:
	descriptive_text = get_node("/root/Main/DescriptiveText")
	pressed.connect(_emit_button_pressed_signal)


func _emit_button_pressed_signal():
	on_space_clicked.emit(self)
	

func _update_sprite(new_sprite):
	texture_normal = new_sprite
	

func _set_selection_border_visible():
	selection_border.visible = true


func _set_selection_border_invisible():
	selection_border.visible = false
