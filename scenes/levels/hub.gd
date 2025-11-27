extends Node

var mirror_dialogue = load("res://dialogue/mirror.dialogue")
var player = null

func _ready():
	$player.global_position = $PlayerSpawn.global_position
	player = get_tree().get_first_node_in_group("player")
	

func _on_fire_mirror_interact():
	if not GameState.fire_complete:
		get_tree().change_scene_to_file("res://scenes/levels/fire/fire.tscn")
	else:
		player.busy = true
		DialogueManager.show_dialogue_balloon(mirror_dialogue, "fire")
		await DialogueManager.dialogue_ended
		player.busy = false
	
func _on_water_mirror_interact():
	if not GameState.water_complete:
		get_tree().change_scene_to_file("res://scenes/levels/water/water.tscn")
	else:
		player.busy = true
		DialogueManager.show_dialogue_balloon(mirror_dialogue, "water")
		await DialogueManager.dialogue_ended
		player.busy = false
