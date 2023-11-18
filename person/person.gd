extends Area2D

var velocity = Vector2.RIGHT
var point_value = 30

const SPEED = 25

@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	global_position += velocity * SPEED * delta


func _process(_delta):
	if global_position.x > Global.SCREEN_BOUND_MAX_X or global_position.x < Global.SCREEN_BOUND_MIN_X:
		queue_free()


func flip_direction():
	velocity = -velocity
	sprite.flip_h = not sprite.flip_h


func _on_area_entered(area):
	if area.is_in_group("Player"):
		Global.saved_people_count += 1
		GameEvents.emit_signal("update_collected_people_count")
		Global.current_points += point_value
		GameEvents.emit_signal("update_points")
		queue_free()
