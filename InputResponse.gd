extends VBoxContainer

# Normal variables
var player_console_input = " >>: "

# In this function we set text for the user input and response
func set_text(input: String, response: String):
	$InputHistory.text = player_console_input + input
	$Response.text = response
