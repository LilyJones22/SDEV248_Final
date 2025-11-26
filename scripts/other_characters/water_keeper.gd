extends Area2D

var dialogue = load("res://dialogue/water_keeper.dialogue") # dialogue file
var can_interact = false

var interactable_areas = []

func _ready():
	$AnimationPlayer.play("idle")
	

func _physics_process(_delta):
	var overlapping_areas = get_overlapping_areas()
	var current_interactables = []
	
	if GameState.talked_water:
		can_interact = false

	for area in overlapping_areas:
		if can_interact:
			if area.is_in_group("interact") and area.visible: 
				current_interactables.append(area)
				
				if not interactable_areas.has(area):
					DialogueManager.show_dialogue_balloon(dialogue, "start")
					await DialogueManager.dialogue_ended
					# other dialogue things here
				
		
			
	interactable_areas = current_interactables
