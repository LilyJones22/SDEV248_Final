extends Area2D

var health = 1
var speed = 300
var direction = Vector2.RIGHT


func _physics_process(delta):
	global_position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage()
		queue_free()
