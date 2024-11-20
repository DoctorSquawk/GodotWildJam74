extends InteractiveObject

var object_empty_message:String = "Chest has been opened and is empty"

func _ready() -> void:
	super()
	sprite.play("Closed")


func _on_object_interaction(object):
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		item_not_used.emit()
		return
	
	if object == Globals.inventory_item.SHEARS:
		_open_object("The straps fall away and you open the chest! You got a pair of pliers.")
		sprite.play("Opened")
		play_sound_effect(open_sound)
	else:
		descriptive_text._update_text("That doesn't seem to work...chest is still strapped shut")
		play_sound_effect(interaction_failure_sound)
		item_not_used.emit()


func _on_player_interaction():
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		return
	
	descriptive_text._update_text("Chest appears to be strapped shut. The straps look like they could be cut.")
	play_sound_effect(interaction_failure_sound)
