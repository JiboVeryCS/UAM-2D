extends StaticBody2D

@export var primaryDropScene: PackedScene
@export var secondaryDropScene: PackedScene
@export var dropQuantity: int
@export var dropVariaty: int
@export var p: float
@export var maxHP: int
var allDrops: Array
var HP
var itemDrop
var rng = RandomNumberGenerator.new()
var xOffset: float
var yOffset: float
var defense: int = 15

func _ready() -> void:
	allDrops.append(primaryDropScene)
	allDrops.append(secondaryDropScene)
	HP = maxHP
	add_to_group("environment")

func damage(dmg: int) -> void:
	HP -= dmg
	if HP <= 0:
		call_deferred("handle_death")
		return

	modulate = Color(0.822, 0.0, 0.0, 1.0)
	$Timer.start()

func _on_timer_timeout() -> void:
	modulate = Color("FFFFFF")
	$Timer.stop()

func handle_death():
	for i in allDrops:
		for j in range(dropQuantity):
			xOffset = rng.randf_range(-25.0, 25.0)
			yOffset = rng.randf_range(-25.0, 25.0)
			for k in range(dropVariaty):
				var P = rng.randf_range(0.0, 1.0)
				if P >= p:
					itemDrop = i.instantiate()
					get_parent().add_child(itemDrop)
					itemDrop.global_position = global_position + Vector2(xOffset, yOffset)
		queue_free()

func spawn_label(dmg: int, crit = false) -> void:
	var label := Label.new()
	label.z_index = 100
	label.scale = Vector2(0.1, 0.1)
	label.text = str(dmg)
	var label_settings := LabelSettings.new()
	label_settings.font_size = 128
	if crit: label_settings.font_color = Color(1.0, 0.74, 0.28, 1.0)
	label.label_settings = label_settings
	label.global_position = global_position + Vector2(randf_range(-25.0, 25.0), randf_range(-25.0, 25.0))
	var timer := Timer.new()
	timer.timeout.connect(func():
		label.queue_free()
		)
	label.add_child(timer)
	get_parent().add_child(label)
	timer.start(2.0)
