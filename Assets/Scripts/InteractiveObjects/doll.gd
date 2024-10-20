extends InteractiveObject

@export var base_animator:AnimatedSprite2D
@export var eye_animator:AnimatedSprite2D
@export var arms_animator:AnimatedSprite2D
@export var stake_animator:AnimatedSprite2D
@export var mouth_animator:AnimatedSprite2D

var init_idle: = true
var arms_set:bool = false
var arms_repaired:bool = false
var eye_set:bool = false
var eye_repaired:bool = false
var stake_removed:bool = false
var stake_repaired:bool = false

signal on_arms_set
signal on_arms_repaired
signal on_eye_set
signal on_eye_repaired
signal on_stake_removed
signal on_stake_repaired


func _on_object_interaction(object):
	if init_idle:
		descriptive_text._update_text("You're not sure what using this item on that would do yet.")
		item_not_used.emit()
		return
	
	match object:
		Globals.inventory_item.ARMS:
			_set_arms()
		Globals.inventory_item.EYE:
			_set_eye()
		Globals.inventory_item.PLIERS:
			_remove_stake()
		Globals.inventory_item.THREAD:
			if not arms_set && not eye_set && not stake_removed:
				descriptive_text._update_text("There are some things to take care of first before doing that")
				item_not_used.emit()
				return
			
			descriptive_text._update_text("")
			
			if arms_set && not arms_repaired:
				_repair_arms()
			if eye_set && not eye_repaired:
				_repair_eye()
			if stake_removed && not stake_repaired:
				_repair_stake()
				
			if (arms_repaired and eye_repaired and stake_repaired):
				_complete_repairs()
		_:
			descriptive_text._update_text("That doesn't seem to do anything")
			item_not_used.emit()


func _on_player_interaction():
	if not init_idle:
		return
	
	descriptive_text._update_text("It appears to be a doll. Seems like it's missing its eye and arms. There's also a stake driven through it, pinning it to the chair it sits in. Creepy. Maybe you can fix it up.")
	init_idle = false
	base_animator.play("interact_idle")
	mouth_animator.play("mouth_frown")


func _set_arms():
	descriptive_text._update_text("The arms are in place and ready to be attached to the doll")
	arms_set = true
	arms_animator.play("toggle_on")
	on_arms_set.emit()


func _repair_arms():
	descriptive_text._add_new_text("The arms have been sewn back onto the doll")
	arms_repaired = true
	on_arms_repaired.emit()


func _set_eye():
	descriptive_text._update_text("The eye has been set in place but is not secure yet.")
	eye_set = true
	eye_animator.play("toggle_on")
	on_eye_set.emit()
	

func _repair_eye():
	descriptive_text._add_new_text("The eye has been sewn onto the doll")
	eye_repaired = true
	on_eye_repaired.emit()


func _remove_stake():
	descriptive_text._update_text("You twist the wooden stake free from its position using the pliers. There is now a hole left in the doll's body.")
	stake_removed = true
	on_stake_removed.emit()


func _repair_stake():
	descriptive_text._add_new_text("The hole has been stitched shut")
	stake_repaired = true
	stake_animator.play("toggle_on")
	on_stake_repaired.emit()


func _complete_repairs():
	descriptive_text._update_text("The doll has been completely repaired!")
	mouth_animator.play("mouth_smile")
	pass
