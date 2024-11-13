extends InteractiveObject

var object_empty_message:String = "The toolbox is open and empty"

func _ready() -> void:
	super()
	sprite.play("Closed")


func _on_object_interaction(object):
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		item_not_used.emit()
		return

	if object == Globals.inventory_item.KEY:
		_open_object("The key fits the lock and the toolbox opens. You've found a prybar")
		sprite.play("Opened")
	else:
		item_not_used.emit()


func _on_player_interaction():
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		return
		
	descriptive_text._update_text("The toolbox appears to be locked")
