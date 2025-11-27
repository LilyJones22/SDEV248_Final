extends Node

var keeper_talked = false

@export var total_enemies = 2

func _ready():
	$"Fire Keeper".hide()
	$ExitMirror.hide()
	$player.show()
	$player.global_position = $PlayerSpawn.global_position
	
	$KeeperAppear.visible = false
	$MirrorAppear.visible = false
	
func enemies_gone():
	$KeeperAppear.visible = true
	$"Fire Keeper".show()
	$"Fire Keeper".can_interact = true

func _on_fire_keeper_talked():
	$MirrorAppear.visible = true
	$ExitMirror.show()
	$ExitMirror.can_interact = true

func _on_fire_enemy_death():
	total_enemies -= 1
	check_total_dead()
		
func _on_fire_enemy_2_death():
	total_enemies -= 1
	check_total_dead()


func check_total_dead():
	if total_enemies == 0:
		enemies_gone()

func _on_exit_mirror_interact():
	GameState.fire_complete = true
	get_tree().change_scene_to_file("res://scenes/levels/hub.tscn")
