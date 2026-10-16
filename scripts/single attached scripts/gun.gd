extends Area2D

var bulletScene: PackedScene = load("res://scenes/items/base_bullet.tscn")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("leftclick"):
		var bullet = bulletScene.instantiate()
		bullet.global_position = $Gunpoint.global_position
		bullet.global_rotation = global_rotation
		bullet.playerPath = "dkjdlkdkdkld"
		get_tree().get_first_node_in_group("Map").add_child(bullet)
