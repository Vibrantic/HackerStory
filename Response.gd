extends Label


func _ready():
	ui_forward_anim() #Triggering the typewriter effect animation

#Animation using Tween for the typewritter effect
func ui_forward_anim() -> void:
	$Tween.interpolate_property(
		self, "percent_visible", 
		0.0, 1.0, 0.75, Tween.TRANS_LINEAR)
	$Tween.start()
