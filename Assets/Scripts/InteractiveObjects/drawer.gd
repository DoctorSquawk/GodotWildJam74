extends InteractiveObject


var object_empty_message:String = "Drawer has been opened and is empty"

func _on_object_interaction(object):
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		item_not_used.emit()
		return
		
	if object == Globals.inventory_item.PRYBAR:
		_open_object("The wood on the drawer splinters as it is forced open. You've obtained a button eye")
	else:
		descriptive_text._update_text("That doesn't seem to work...The drawer is still stuck fast.")
		item_not_used.emit()


func _on_player_interaction():
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		return
	
	descriptive_text._update_text("The drawer appears to be stuck in place. Maybe some extra leverage would help.")
