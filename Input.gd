extends LineEdit

# Once the game start we grap the focus to input field
func _ready() -> void:
	grab_focus()

# This function clears the user input field
func _on_Input_text_entered(new_text: String) -> void:
	clear()
