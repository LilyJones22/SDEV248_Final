extends Area2D

@export var next : PackedScene

var interactable_areas = []

func _physics_process(delta):
	var overlapping_areas = get_overlapping_areas()
	var current_interactables = []
	
	for area in overlapping_areas:
		if area.is_in_group("interact") and area.visible: 
			current_interactables.append(area)
			
			if not interactable_areas.has(area):
				get_tree().change_scene_to_packed(next)
				
		
			
	interactable_areas = current_interactables
