extends Camera2D

const FOLLOW_SPEED = 9

var target_position = global_position


func _ready():
	GameEvents.connect("camera_follow_player", Callable(self, "_follow_player"))


func _physics_process(delta):
	global_position.y = lerp(global_position.y, target_position.y, FOLLOW_SPEED * delta)


func _follow_player(player_y):
	target_position.y = clamp(player_y, 70, 145)
