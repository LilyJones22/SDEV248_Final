extends Area2D

signal talked

var dialogue = load("res://dialogue/fire_keeper.dialogue") # dialogue file
var can_interact = false
var player = null

var interactable_areas = []

func _ready():
	player = get_tree().get_first_node_in_group("player")
	$AnimationPlayer.play("idle")


func _physics_process(_delta):
	var overlapping_areas = get_overlapping_areas()
	var current_interactables = []
	
	
	for area in overlapping_areas:
		if can_interact:
			if area.is_in_group("interact") and area.visible: 
				current_interactables.append(area)
				
				if not interactable_areas.has(area):
					if not player.busy:
						player.busy = true
						DialogueManager.show_dialogue_balloon(dialogue, "start")
						await DialogueManager.dialogue_ended
						
						# other dialogue things here
						emit_signal("talked")
						can_interact = false
						player.busy = false
				
		
			
	interactable_areas = current_interactables
