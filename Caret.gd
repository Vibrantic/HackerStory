extends Label

var anim_called = false
var anim_forward_called = false
var anim_backward_called = false

onready var timer = $Timer

func _ready():
	timer.set_wait_time(1)
	timer.start()

func ui_backward_anim() -> void:
	$Tween.interpolate_property(
		self, "percent_visible", 
		1.0, 0.0, 0.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func ui_forward_anim() -> void:
	$Tween.interpolate_property(
		self, "percent_visible", 
		0.0, 1.0, 0.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

	
func _on_Timer_timeout():
	if anim_called == false:
		anim_called = true
		ui_backward_anim()
	elif anim_called == true:
		anim_called = false	
		ui_forward_anim()
	pass # Replace with function body.
