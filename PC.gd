extends PanelContainer
class_name NetDevices

#Exported variables
export (String) var pc_ip = "123.456.78.9"
export (String) var device_name = "Name-PC"
export (String) var processor_name = "Amtel F-Core 4x4.00 GHz"
export (String) var installed_ram = "8 GB"
export (String) var system_type = "Lindows 7.5 Version 22H5"

var disconnect: Dictionary = {}
var connect: Dictionary = {}


func connect_disconnect(destination: String, pc: NetDevices):
	match destination:
		"disconnect":
			disconnect[destination] = pc
			pc.disconnect["disconnect"] = self
		
		"1.1.1.1":
			connect[destination] = pc
			pc.connect["ECOTECH_PC"] = self
		
		_:
			printerr("Tried to connect invalid destination: %s", destination)
