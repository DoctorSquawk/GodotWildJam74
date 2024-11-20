extends InteractiveObject

var object_empty_message:String = "Box has been opened and is empty"

func _ready() -> void:
	super()
	sprite.play("Closed")


func _on_object_interaction(object):
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		item_not_used.emit()
		return
	
	if object == Globals.inventory_item.PRYBAR:
		_open_object("The box lid pops off! You got a pair of garden shears.")
		sprite.play("Opened")
		play_sound_effect(open_sound)
	else:
		descriptive_text._update_text("That doesn't seem to work...the box lid is tightly shut")
		play_sound_effect(interaction_failure_sound)
		item_not_used.emit()


func _on_player_interaction():
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		return
	
	descriptive_text._update_text("The box lid appears to be nailed down")
	play_sound_effect(interaction_failure_sound)
