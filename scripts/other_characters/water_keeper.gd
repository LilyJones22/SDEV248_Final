extends Area2D

var dialogue = load() # dialogue file

var interactable_areas = []

func _ready():
	$AnimationPlayer.play("idle")

func _physics_process(delta):
	var overlapping_areas = get_overlapping_areas()
	var current_interactables = []
	
	for area in overlapping_areas:
		if area.is_in_group("interact") and area.visible: 
			current_interactables.append(area)
			
			if not interactable_areas.has(area):
				DialogueManager.show_dialogue_balloon(dialogue, "start")
				await DialogueManager.dialogue_ended
				# other dialogue things here
				
		
			
	interactable_areas = current_interactables
