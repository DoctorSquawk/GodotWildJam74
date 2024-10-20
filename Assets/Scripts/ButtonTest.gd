extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_up.connect(_on_interaction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interaction():
	print("Interacting with object")
	pass
