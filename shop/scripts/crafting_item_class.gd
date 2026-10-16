class_name craftingItem

enum tierEnum {
	tier0, tier1, tier2, tier4, tier5
}
enum typeEnum {
	gun, sword
}

@export var ID: int = 0
@export var tier: tierEnum
@export var itemName: String = "buddy"
@export var type: typeEnum
@export var points: int = 60
@export var description: String = ""
@export var texture: String = "icon.svg"

@export var IDOne: int = 0
@export var quantityOne: int = 0
@export var IDTwo: int = 0
@export var quantityTwo: int = 0
@export var IDThree: int = 0
@export var quantityThree: int = 0
@export var IDFour: int = 0
@export var quantityFour: int = 0
@export var rDict: Dictionary = {}

func _init(id: int = 1, name: String = "None", texture_ : String = "icon.svg", I: int = 0, nI: int = 0, 
II: int = 0, nII: int = 0, III: int = 0, nIII: int = 0, IV: int = 0, nIV: int = 0) -> void:
	ID = id
	itemName = name
	texture = texture_
	IDOne = I
	quantityOne = nI
	IDTwo = II
	quantityTwo = nII
	IDThree = III
	quantityThree = nIII
	IDFour = IV
	quantityFour = nIV

func to_dict() -> Dictionary:
	return {
		"tier" = tier,
		"name" = itemName,
		"description" = description,
		"texture" = texture,
		"IDOne" = IDOne,
		"quantityOne" = quantityOne,
		"IDTwo" = IDTwo,
		"quantityTwo" = quantityTwo,
		"IDThree" = IDThree,
		"quantityThree" = quantityThree,
		"IDFOur" = IDFour,
		"quantityFour" = quantityFour
	}

func from_dict(data: Dictionary) -> void:
	ID = data.get("id", 0)
	tier = data.get("tier", 0)
	itemName = data.get("itemName", "")
	points = data.get("points", 0)
	description = data.get("description", "")
	texture = data.get("texture", load("res://icon.svg"))
	IDOne = data.get("IDOne", -1)
	quantityOne = data.get("quantityOne", 0)
	IDTwo = data.get("IDTwo", -1)
	quantityTwo = data.get("quantityTwo", 0)
	IDThree = data.get("IDThree", -1)
	quantityThree = data.get("quantityThree", 0)
	IDFour = data.get("IDFour", -1)
	quantityFour = data.get("quantityFour", 0)

	rDict = {
		"ID": [IDOne, IDTwo, IDThree, IDFour],
		"n": [quantityOne, quantityTwo, quantityThree, quantityFour]
	}

func get_texture(append_res : bool = true) -> Texture2D:
	var path: String = ("res://" if append_res else "") + texture
	return load(path)
