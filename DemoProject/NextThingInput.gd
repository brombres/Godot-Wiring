extends LineEdit

func _on_text_submitted( _text:String ):
	add_thing()

func add_thing():
	if text:
		Wiring.ItemList.add_item( text )

		var event_log = Wiring.TextEdit
		if event_log.text: event_log.text += "\n"
		event_log.text += "Added " + text

		var v_scroll = Wiring.TextEdit.get_v_scroll_bar()
		v_scroll.value = v_scroll.max_value
		text = ""
