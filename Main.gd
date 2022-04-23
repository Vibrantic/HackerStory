extends Control

# Constants
const Response = preload("res://Response.tscn")
const InputResponse = preload("res://InputResponse.tscn")

# Exported variables
export (int) var max_lines_remembered := 30

# Normal variables
var max_scroll_length := 0
var player_consol_output = " C:/ "
var clear = ["cls", "clear", "cl"]
var game = ["start", "load", "quit"]

var start = false
var load_game = false 

# Onready variables
onready var command_processor = $CommandProcessor
onready var history_rows = $Background/MarginContainer/Rows/InfoArea/ScrollContainer/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/InfoArea/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()
onready var net_manager = $NetManager

func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	
	handle_response_generated(".................................................................................")
	
	handle_response_generated("Start, Load, Quit")	

func startgame() -> void: 
	command_processor.connect("response_generated", self, "handle_response_generated")
	command_processor.initialize(net_manager.get_child(0))
	
	
func loadgame() -> void: 
	command_processor.connect("response_generated", self, "handle_response_generated")
	command_processor.initialize(net_manager.get_child(0))
	
# Function for updating the scrollbar based on how much text on the screen is created	
func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = scrollbar.max_value

# Function for handling the text input and output
func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return

	elif clear.has(new_text):
		cls()
	
	elif game.has(new_text):
		if new_text == "start":
			start = true
			startgame()
			pass
			
		elif new_text == "load":
			loadgame()
			pass
			
		elif new_text == "quit":
			get_tree().quit()
			
		else:
			pass
			
	var input_response = InputResponse.instance()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, player_consol_output + response)
	add_response_to_game(input_response)


func handle_response_generated(response_text: String):
	var response = Response.instance()
	response.text = response_text
	add_response_to_game(response)


# Function for spawning the response	
func add_response_to_game(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limit()

# Once the limit is reached the first row is getting deleted		
func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()

# Function for clearing the screen			
func cls():
	var rows_to_forget = history_rows.get_child_count()
	for i in range(rows_to_forget):
		history_rows.get_child(i).queue_free()
		
