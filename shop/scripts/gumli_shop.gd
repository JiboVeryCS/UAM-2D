extends StaticBody2D

var Shop: bool = false

func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Shop = true

func _on_hitbox_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		Shop = false

func _process(_delta: float) -> void:
	if Shop:
		if Input.is_action_just_pressed("leftclick"):
			GameManager.alrInMenu = true
			get_tree().paused = true
			get_node("/root/testScene/craftingUI").show()
		if Input.is_action_just_pressed("esc"):
			GameManager.alrInMenu = false
			get_tree().paused = false
			get_node("/root/testScene/craftingUI").hide()
