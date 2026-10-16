class_name invItem

enum rarityEnum {
	common, uncommon, rare, legendary
}

@export var ID: int
@export var rarity: rarityEnum
@export var itemName: String = "" 
@export var description: String = ""
@export var texture: String = "icon.svg"

func _init(id: int = 1, name: String = "None", texture_ : String = "icon.svg") -> void:
	ID = id
	itemName = name
	texture = texture_

func to_dict() -> Dictionary:
	return {
		"rarity" = rarity,
		"name" = itemName,
		"description" = description,
		"texture" = texture
	}

func from_dict(data: Dictionary) -> void:
	ID = data.get("id", 0)
	rarity = data.get("rarity", 0)
	itemName = data.get("itemName", "")
	description = data.get("description", "")
	texture = data.get("texture", load("res://icon.svg"))

func get_texture(append_res : bool = true) -> Texture2D:
	var path: String = ("res://" if append_res else "") + texture
	return load(path)
