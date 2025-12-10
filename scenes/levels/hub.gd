extends Node

var mirror_dialogue = load("res://dialogue/mirror.dialogue")
var player = null

func _ready():
	$"Final Mirror".visible = false
	$player.global_position = $PlayerSpawn.global_position
	player = get_tree().get_first_node_in_group("player")
	
	if GameState.air_complete and GameState.water_complete and GameState.earth_complete and GameState.fire_complete and GameState.spirit_complete:
		$"Final Mirror".visible = true


func _on_air_mirror_interact():
	if not GameState.air_complete:
		get_tree().change_scene_to_file("res://scenes/levels/air/air.tscn")
	else:
		if not player.busy:
			player.busy = true
			DialogueManager.show_dialogue_balloon(mirror_dialogue, "air")
			await DialogueManager.dialogue_ended
			player.busy = false

func _on_fire_mirror_interact():
	if not GameState.fire_complete:
		get_tree().change_scene_to_file("res://scenes/levels/fire/fire.tscn")
	else:
		if not player.busy:
			player.busy = true
			DialogueManager.show_dialogue_balloon(mirror_dialogue, "fire")
			await DialogueManager.dialogue_ended
			player.busy = false
			
func _on_spirit_mirror_interact():
	if not GameState.spirit_complete:
		get_tree().change_scene_to_file("res://scenes/levels/spirit/spirit.tscn")
	else:
		if not player.busy:
			player.busy = true
			DialogueManager.show_dialogue_balloon(mirror_dialogue, "spirit")
			await DialogueManager.dialogue_ended
			player.busy = false
	
func _on_water_mirror_interact():
	if not GameState.water_complete:
		get_tree().change_scene_to_file("res://scenes/levels/water/water.tscn")
	else:
		if not player.busy:
			player.busy = true
			DialogueManager.show_dialogue_balloon(mirror_dialogue, "water")
			await DialogueManager.dialogue_ended
			player.busy = false

func _on_earth_mirror_interact():
	if not GameState.earth_complete:
		get_tree().change_scene_to_file("res://scenes/levels/earth/earth.tscn")
	else:
		if not player.busy:
			player.busy = true
			DialogueManager.show_dialogue_balloon(mirror_dialogue, "earth")
			await DialogueManager.dialogue_ended
			player.busy = false

func _on_final_mirror_interact():
	if GameState.preserve_count > GameState.reject_count:
		get_tree().change_scene_to_file("res://scenes/cutscene/accept_ending.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/cutscene/reject_ending.tscn")
