extends CharacterBody2D

signal health_changed(amount_changed)
signal magic_changed(amount_changed)

@export var speed = 100
@export var health = 20
@export var magic = 30

@export var weapon_scene: PackedScene
@export var game_over: PackedScene

@onready var attack_spawn_point = $AttackSpawnPoint

var direction = Vector2.ZERO 
var facing = "down"
var attacking = false
var busy = false

func _ready(): # on startup things
	$Interact.hide() # ensure player interact area hidden


func get_input(): # standard input behavior
	direction = Vector2.ZERO
	
	if not busy:
		if Input.is_action_pressed("move_up"):
			if not attacking:
				facing = "up"
				$AnimationPlayer.play("walk_up")
				direction.y -= 1
		elif Input.is_action_pressed("move_down"):
			if not attacking:
				facing = "down"
				$AnimationPlayer.play("walk_down")
				direction.y += 1
		elif Input.is_action_pressed("move_left"):
			if not attacking:
				facing = "left"
				$AnimationPlayer.play("walk_left")
				direction.x -= 1
		elif Input.is_action_pressed("move_right"):
			if not attacking:
				facing = "right"
				$AnimationPlayer.play("walk_right")
				direction.x += 1
		
		if Input.is_action_just_pressed("attack"):
			if magic > 0:
				attacking = true
				if facing == "up":
					$AnimationPlayer.play("attack_up")
				elif facing == "down":
					$AnimationPlayer.play("attack_down")
				elif facing == "left":
					$AnimationPlayer.play("attack_left")
				elif facing == "right":
					$AnimationPlayer.play("attack_right")
				
				await get_tree().create_timer(1).timeout
				deal_damage()
		
	if Input.is_action_just_pressed("interact"):
		$Interact.show()
	else:
		$Interact.hide()
		

func take_damage(): # if player gets hurt -- TO DO: animation
	health_changed.emit(-1)
	health -= 1
	
func _physics_process(_delta):
	get_input()
	velocity = direction * speed
	if direction == Vector2.ZERO: # player not moving
		if not attacking:
			if facing == "up":
				$AnimationPlayer.play("idle_up")
			elif facing == "down":
				$AnimationPlayer.play("idle_down")
			elif facing == "left":
				$AnimationPlayer.play("idle_left")
			elif facing == "right":
				$AnimationPlayer.play("idle_right")
	else:	
		move_and_slide()
	
	if health == 0:
		die()
	
func deal_damage(): # player deals damage
	magic_changed.emit(-1)
	magic -= 1
	var attack_instance = weapon_scene.instantiate()
	get_parent().add_child(attack_instance)
	attack_instance.global_position = attack_spawn_point.global_position
	match facing:
		"right": attack_instance.direction = Vector2.RIGHT
		"left": attack_instance.direction = Vector2.LEFT
		"up": attack_instance.direction = Vector2.UP
		"down": attack_instance.direction = Vector2.DOWN
	attacking = false



func die(): # end game if player dies
	get_tree().change_scene_to_packed(game_over)
