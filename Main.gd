extends Control

const Response = preload("res://Response.tscn")
const InputResponse = preload("res://InputResponse.tscn")

export (int) var max_lines_remembered := 30

var max_scroll_length := 0

onready var command_processor = $CommandProcessor
onready var history_rows = $Background/MarginContainer/Rows/InfoArea/ScrollContainer/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/InfoArea/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()

var player_consol_output = " C:/ "

var clear = ["cls", "clear", "cl"]

func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	
	var starting_message = Response.instance()
	starting_message.text = player_consol_output + "O boy! How did you wound up here in this chat?! "
	add_response_to_game(starting_message)
	
func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = scrollbar.max_value


func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return

	elif clear.has(new_text):
		cls()

	var input_response = InputResponse.instance()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, player_consol_output + response)
	add_response_to_game(input_response)

	
func add_response_to_game(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limit()
		
func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
			
func cls():
	var rows_to_forget = history_rows.get_child_count()
	for i in range(rows_to_forget):
		history_rows.get_child(i).queue_free()
		
