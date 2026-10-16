extends Area2D

var speed = 500
var baseDmg = 10
var objectsAlreadyTouched: Array[Node2D]
var direction: Vector2 = Vector2(1, 0)
var pierce = 1
@onready var player = get_node("/root/testScene/Player")
var playerPath

func _ready() -> void:
	direction = direction.rotated(rotation - deg_to_rad(90))
	$DespawnTimer.start(2)

func _physics_process(delta: float) -> void:
	global_position += speed * delta * direction

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("environment"):
		if objectsAlreadyTouched.has(area):
			return
		var d = MathManager.damage_taken(baseDmg, player.strength, area.get_parent().defense)
		area.get_parent().damage(d)
		area.get_parent().spawn_label(d)
		pierce -= 1
		objectsAlreadyTouched.append(area)
	if pierce <= 0:
			queue_free()

func _on_despawn_timer_timeout() -> void:
	queue_free()
