extends Area2D

signal talking
signal talked

var dialogue = load("res://dialogue/fire_keeper.dialogue") # dialogue file
var can_interact = false

var interactable_areas = []

func _ready():
	$AnimationPlayer.play("idle")


func _physics_process(_delta):
	var overlapping_areas = get_overlapping_areas()
	var current_interactables = []
	
	
	for area in overlapping_areas:
		if can_interact:
			if area.is_in_group("interact") and area.visible: 
				current_interactables.append(area)
				
				if not interactable_areas.has(area):
					emit_signal("talking")
					DialogueManager.show_dialogue_balloon(dialogue, "start")
					await DialogueManager.dialogue_ended
					
					# other dialogue things here
					emit_signal("talked")
					can_interact = false
				
		
			
	interactable_areas = current_interactables
