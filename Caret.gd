extends Label

#Normal variables
var anim_called = false

#Onready variables 
onready var timer = $Timer


func _ready():
	timer.set_wait_time(1) #Time is set on 1 sec
	timer.start() #Timer is activated

# Blinking animations for user input ">>:" with the help of Tween
func userinput_anim() -> void:
	if anim_called == true:
		$Tween.interpolate_property(
			self, "percent_visible", 
			1.0, 0.0, 0.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.start()
		anim_called = false
	else:
		$Tween.interpolate_property(
		self, "percent_visible", 
		0.0, 1.0, 0.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.start()
		anim_called = true

# This timer triggers the animation for user input
func _on_Timer_timeout():
	userinput_anim()
	pass # Replace with function body.
