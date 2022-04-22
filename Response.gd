extends Label


func _ready():
	ui_forward_anim()

func ui_forward_anim() -> void:
	$Tween.interpolate_property(
		self, "percent_visible", 
		0.0, 1.0, 0.75, Tween.TRANS_LINEAR)
	$Tween.start()
