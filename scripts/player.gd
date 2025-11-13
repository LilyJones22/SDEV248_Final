extends CharacterBody2D

@export var speed = 200

var direction = Vector2.ZERO

func get_input(): # standard input behavior
	direction = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		# $AnimationPlayer.play("walk_up")		ADD LATER
		direction.y -= 1
	elif Input.is_action_pressed("move_down"):
		# $AnimationPlayer.play("walk_down") 	ADD LATER
		direction.y += 1
	elif Input.is_action_pressed("move_left"):
		# $AnimationPlayer.play("walk_left") 	ADD LATER
		direction.x -= 1
	elif Input.is_action_pressed("move_right"):
		# $AnimationPlayer.play("walk_right")	ADD LATER
		direction.x += 1

func take_damage(): # if player gets hurt -- TO DO
	print("Ouch!")
	
	
func _physics_process(delta):
	get_input()
	velocity = direction * speed
	move_and_slide()
	
func _on_attract_body_entered(body): # enemy enters outer circle
	if body.is_in_group("enemy"):
		body.attack_timer.start()

func _on_attract_body_exited(body): # enemy leaves outer circle
	if body.is_in_group("enemy"):
		body.attack_timer.stop()
		body.state = body.SURROUND

func _on_attack_body_entered(body): # enemy enters innter circle
	if body.is_in_group("enemy"):
		body.state = body.HIT

func _on_attack_body_exited(body): # enemy enters inner circle
	if body.is_in_group("enemy"):
		body.state = body.SURROUND
