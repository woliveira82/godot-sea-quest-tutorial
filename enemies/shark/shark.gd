extends Area2D


const SPEED = 50
const MOVEMENT_FREQUENCY = 0.15
const MOVEMENT_AMPLITUDE = 0.5

var velocity = Vector2.RIGHT
var random_offset = randf_range(0.0, 10.0)

@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	velocity.y = sin(global_position.x * MOVEMENT_FREQUENCY + random_offset) * MOVEMENT_AMPLITUDE
	global_position += velocity * SPEED * delta


func flip_direction():
	velocity = -velocity
	sprite.flip_h = not sprite.flip_h


func _on_area_entered(area):
	if area.is_in_group("PlayerBullet"):
		area.queue_free()
		queue_free()


func _on_screen_exited():
	queue_free()
