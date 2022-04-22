extends Tween


func _ready():
	ui_forward_anim()

func ui_forward_anim() -> void:
	$Tween.interpolate_property(
		self, "percent_visible", 
		0.0, 1.0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
