extends Area2D

var velocity = Vector2.RIGHT

const SPEED = 25

@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	global_position += velocity * SPEED * delta


func flip_direction():
	velocity = -velocity
	sprite.flip_h = not sprite.flip_h


func _on_area_entered(area):
	if area.is_in_group("Player"):
		queue_free()
