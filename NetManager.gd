extends Node


func _ready() -> void:
	$USER_PC.connect_disconnect("1.1.1.1", $ECOTECH_PC)
	$ECOTECH_PC.connect_disconnect("disconnect", $USER_PC)
