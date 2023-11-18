extends Label


func _ready():
	GameEvents.connect("update_points", Callable(self, "_points_updated"))


func _points_updated():
	text = str(Global.current_points)
