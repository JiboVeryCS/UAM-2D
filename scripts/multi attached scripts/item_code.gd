extends Area2D

@onready var inventoryUI: Node = get_node("/root/testScene/InventoryUI/Control")
@export var item: String = "empty"
@export var itemDescription: String = "empty description"
@export var texturePath: String = "res://icon.svg"
@export var rotateSprite: bool = false
@export var sprite: Sprite2D
@export var ID: int = 0
var rotationDegrees: float = 0.0
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	if rotateSprite and sprite != null:
		rng.randomize()
		rotationDegrees = rng.randf_range(-20.0, 20.0)
		sprite.rotation = deg_to_rad(rotationDegrees)
	elif rotateSprite and sprite == null:
		push_error("CUSTOM: sprite cannot be found")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.inventory.add_item(ID)
		inventoryUI.update_inventory()
		queue_free()
