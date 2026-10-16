@icon("res://gummed.png")
class_name TeamPlayer2D extends CharacterBody2D
## the team player class.

var rng := RandomNumberGenerator.new()
var walkingSpeed: int = 200
var currentSpeed: float = 200
var sprintSpeed: int = 300
var strength: int = 50
var direction: Vector2
var last_direction: Vector2
var currentEquipment: int = 0
var points: int = 100
var gunScene: PackedScene = load("res://scenes/items/gun.tscn")
var gun

func _ready():
	rng.randomize()

func _process(_delta: float) -> void:
	direction = Input.get_vector("a", "d", "w", "s")
	velocity = currentSpeed * direction
	move_and_slide()
	if Input.is_action_pressed("ctrl"):
		if currentSpeed <= sprintSpeed:
			currentSpeed += 2.5
	else: currentSpeed = walkingSpeed
	if direction != Vector2.ZERO:
		last_direction = direction
	$Marmi.rotation = last_direction.angle() + deg_to_rad(90)

	if Input.is_action_just_pressed("scrollwheel_up"):
		if currentEquipment >= 1:
			currentEquipment = 0
		else:
			currentEquipment += 1
		load_gun()
	if Input.is_action_just_pressed("scrollwheel_down"):
		if currentEquipment <= 0:
			currentEquipment = 1
		else:
			currentEquipment -= 1
		load_gun()
	
func load_gun() -> void:
	if gun: 
		gun.queue_free()
	if currentEquipment == 1:
		gun = gunScene.instantiate()
		$Marmi/RotationBar/EquipmentPosition.add_child(gun)

func damage_taken(base_damage: float, attack: float, defense: float, invincibility: bool = false) -> int:
	if invincibility: return 0
	var total_dmg = base_damage * attack / (base_damage + defense)
	var offset = rng.randf_range((-1) * total_dmg * 0.1, total_dmg * 0.1)
	total_dmg = (base_damage *  attack / (base_damage + defense) + offset)
	var critical_hit = int(rng.randf_range(0, 25))
	if critical_hit == 1:
		total_dmg *= 1.5
		GameManager.criticalHit = true
	else:
		GameManager.criticalHit = false
	return round(total_dmg)
