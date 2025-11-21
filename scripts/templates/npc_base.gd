extends Area2D

var dialogue = load("res://dialogue/testing.dialogue")

var interactable_areas = []

func _physics_process(delta):
	var overlapping_areas = get_overlapping_areas()
	var current_interactables = []
	
	for area in overlapping_areas:
		if area.is_in_group("interact") and area.visible: 
			current_interactables.append(area)
			
			if not interactable_areas.has(area):
				DialogueManager.show_dialogue_balloon(dialogue, "start")
				await DialogueManager.dialogue_ended
				if GameState.optionA:
					print("Option A")
				elif GameState.optionB:
					print("Option B")
				
		
			
	interactable_areas = current_interactables
