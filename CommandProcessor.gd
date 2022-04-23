extends Node

signal response_generated(response_text)

var current_ip_connected = null
var command_list:Dictionary = {
	0: "help - List of all commands avaliable",
	1: "cd or chdir - Change Directory / move to a specific Folder",
	2: "cl / cls or clear - Clears the screen",
	3: "color + color name - Change colors of the fonts (blue/red/green/yellow)",
	4: "copy - Copy one or more files to another location",
	5: "connect + IP - Connect to the adress",
	6: "del / delete / erase - Delete one or more files",
	7: "dir - Display a list of files and folders",
	8: "disconnect - Disconnect from the connected IP",
	9: "download - Download file/software",
	10: "run / start / use + software name - Run a specific software",
	11: "upload - Upload file/software",
	12: "open - Open specific file",
	13: "buy - Used to buy software/hardware",
	14: "sell - Used to sell software/hardware",
	15: "upgrade - Used to upgrade software/hardware",
	16: "make - Make file or directory",
	17: "call - It can be used for calling a number",
	18: "For thorough explanation type help + number."
}


var connected_to_main = true
var connected_to_ecotech_pc = false


func initialize(connected_pc):
	connect_to_ip(connected_pc)


func process_command(input: String):
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed."
	
	var first_word = words[0].to_lower()
	var second_word = ""
	var third_word = ""
	var forth_word = ""
	
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	elif words.size() > 2:
		third_word = words[2].to_lower()
	
	elif words.size() > 3:
		forth_word = words[3].to_lower()

	match first_word:
		"cls":
			return clear_screen(second_word)
		"clear":
			return clear_screen(second_word)
		"cl":
			return clear_screen(second_word)
		"help":
			return help()
		"connect":
			return ecotech_pc(second_word)
		"disconnect":
			return disconnect_from_pc(first_word)
			
		_:
			return "Unknown command!"
	

func clear_screen(second_word: String) -> String:
	if second_word == "":
		return "Screen cleared!"
	
	return "Sucess"


func ecotech_pc(second_word: String) -> String:
	if second_word == "1.1.1.1" and connected_to_ecotech_pc == false:
		connect_to_ip(current_ip_connected.connect[second_word])
		connected_to_ecotech_pc = true
		connected_to_main = false
		return "Loged in to 1.1.1.1"
	
	elif connected_to_ecotech_pc == true:
		return "You are alrewady connected to this IP."
	
	else:
		return "Failed login!"


func disconnect_from_pc(first_word: String) -> String:
	if first_word == "disconnect" and connected_to_main == false:
		connect_to_ip(current_ip_connected.disconnect[first_word])
		connected_to_ecotech_pc = false
		connected_to_main = true
		return "Loged in to main PC"
	
	elif connected_to_main == true:
		return "You are alrewady connected to your PC."
		
	else:
		return "Failed logout!"
	
func help() -> String:
	return var2str(command_list).replace("{", "").replace("}", "").replace('"', "").replace(",", "")
	

func connect_to_ip(connected_pc: NetDevices):
	current_ip_connected = connected_pc
	var strings = PoolStringArray([
		"Currently connected to " + connected_pc.pc_ip,
		"This device belongs to " + connected_pc.device_name,
		"Processor: " + connected_pc.processor_name,
		"Installed RAM: " + connected_pc.installed_ram,
		"System: " + connected_pc.system_type
	]).join("\n")
	emit_signal("response_generated", strings)
