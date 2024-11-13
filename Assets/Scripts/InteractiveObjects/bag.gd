extends InteractiveObject

var object_empty_message:String = "The bag doesn't seem to contain anything else useful."

func _ready() -> void:
	super()
	sprite.play("Closed")


func _on_object_interaction(object):
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		item_not_used.emit()
		return
	
	if object == Globals.inventory_item.SHEARS:
		_open_object("The shears tear through the fabric and out from the clutter falls a pair of cotton-stuffed doll arms")
		sprite.play("Opened")
	else:
		descriptive_text._update_text("That doesn't appear to work")
		item_not_used.emit()


func _on_player_interaction():
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		return
	
	descriptive_text._update_text("The bag seems tied shut rather tightly but the material doesn't look that strong.")
