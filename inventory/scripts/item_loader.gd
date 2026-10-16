class_name itemLoader

var itemArray: Array[invItem]
var craftArray: Array[craftingItem]
const JSON_PATH: String = "res://inventory/json/item_list.json"

func load_item() -> void: 
	if !FileAccess.file_exists(JSON_PATH):
		push_error("CUSTOM: Item list file does not exist")
		return
	var file = FileAccess.open(JSON_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	for i in data.get("items"):
		var item: invItem = invItem.new()
		item.from_dict(i)
		itemArray.append(item)
	file.close()

func load_crafts() -> void:
	if !FileAccess.file_exists(JSON_PATH):
		push_error("CUSTOM: Item list file does not exist")
		return
	var file = FileAccess.open(JSON_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	for i in data.get("crafts"):
		var item: craftingItem = craftingItem.new()
		item.from_dict(i)
		craftArray.append(item)
	file.close()

func get_item(id: int) -> invItem:
	for i in itemArray:
		if i.ID == id:
			return i
	push_error("CUSTOM: Invalid ID, could not retrieve inventory item data")
	return null

func get_craft(id: int) -> craftingItem:
	for j in craftArray:
		if j.ID == id:
			return j 
	push_error("CUSTOM: Invalid ID, could not retrieve craft item data")
	return null
