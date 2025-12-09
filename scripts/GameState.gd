extends Node

var save_path = "user://veilstorm.save"
var player = null

var preserve_count = 0
var reject_count = 0

var air_complete = false
var water_complete = false
var earth_complete = false
var fire_complete = false
var spirit_complete = false

func _ready():
	player = get_tree().get_first_node_in_group("player")

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(preserve_count)
	file.store_var(reject_count)
	file.store_var(air_complete)
	file.store_var(water_complete)
	file.store_var(earth_complete)
	file.store_var(fire_complete)
	file.store_var(spirit_complete)
	file.store_var(player.health)
	file.store_var(player.magic)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		preserve_count = file.get_var(preserve_count)
		reject_count = file.get_var(reject_count)
		air_complete = file.get_var(air_complete)
		water_complete = file.get_var(water_complete)
		earth_complete = file.get_var(earth_complete)
		fire_complete = file.get_var(fire_complete)
		spirit_complete = file.get_var(spirit_complete)
		player.health = file.get_var(player.health)
		player.magic = file.get_var(player.health)
	else:
		print("File not found. No data saved")
