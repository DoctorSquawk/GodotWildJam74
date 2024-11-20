extends Area2D

@export var sprite:AnimatedSprite2D
@export var collider:CollisionPolygon2D
@export var sound_effect_player:AudioStreamPlayer2D
@export var descriptive_text:Label

@export var open_sound:AudioStreamMP3
@export var interaction_failure_sound:AudioStreamMP3

var is_mouse_hovering:bool = false
var is_opened:bool = false

signal item_not_used
signal on_object_opened

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _process(delta: float) -> void:
	if is_mouse_hovering:
		_attempt_interaction()


func _on_mouse_entered():
	is_mouse_hovering = true
	print("Mouse is hovering")


func _on_mouse_exited():
	is_mouse_hovering = false


func _attempt_interaction():
	if Input.is_action_just_pressed("left_click"):
		if Globals.is_inventory_item_selected:
			_on_object_interaction(Globals.current_selected_inventory_space.held_item)
		else:
			_on_player_interaction()


func _on_object_interaction(object):
	print("Interacting with an object!")
	pass


func _on_player_interaction():
	print("No inventory object selected. Player is interacting directly!")
	pass


func _open_object(open_message):
	descriptive_text._update_text(open_message)
	on_object_opened.emit()


func _set_open():
	is_opened = true


func set_collision_activity(isDisabled:bool):
	collider.disabled = isDisabled


func play_sound_effect(sound_effect:AudioStreamMP3):
	sound_effect_player.stream = sound_effect
	sound_effect_player.play()
