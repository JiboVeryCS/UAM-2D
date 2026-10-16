extends Control

func _on_singleplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/test_scene.tscn")
