extends CanvasLayer


func _on_player_health_changed(amount_changed):
	$Health.value += amount_changed


func _on_player_magic_changed(amount_changed):
	$Magic.value += amount_changed
