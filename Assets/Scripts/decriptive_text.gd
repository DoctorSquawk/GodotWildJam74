extends Label

func _update_text(new_text):
	text = new_text


func _add_new_text(text_to_append):
	if text == "":
		text += text_to_append
		return
	
	text += "\n" + text_to_append
