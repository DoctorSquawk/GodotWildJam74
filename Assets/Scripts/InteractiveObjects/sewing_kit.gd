extends InteractiveObject

var object_empty_message:String = "Nothing else in the kit catches your eye"

func _ready() -> void:
	super()
	sprite.play("Closed")


func _on_object_interaction(object):
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		item_not_used.emit()
		return
	
	descriptive_text._update_text("That doesn't do anything")
	play_sound_effect(interaction_failure_sound)
	item_not_used.emit()


func _on_player_interaction():
	if is_opened:
		descriptive_text._update_text(object_empty_message)
		return
	
	_open_object("You've found a needle and thread")
	sprite.play("Opened")
	play_sound_effect(open_sound)
