extends Area2D

var health = 1
var speed = 300
var direction = Vector2.ZERO


func _physics_process(delta):
	global_position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		speed = 50
		body.take_damage()
		$AnimationPlayer.play("hit")
		await $AnimationPlayer.animation_finished
		queue_free()
