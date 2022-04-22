extends VBoxContainer

var player_console_input = " >>: "

func set_text(input: String, response: String):
	$InputHistory.text = player_console_input + input
	$Response.text = response
