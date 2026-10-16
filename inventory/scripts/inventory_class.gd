class_name inv

@export var inventory: Dictionary

func add_item(item_id: int, count: int = 1) -> void:
	if not inventory.has(item_id):
		inventory.set(item_id, {
			"count" : count,
			"description" : GameManager.item_loader.itemArray[item_id].description
		} )
	else:
		inventory[item_id]["count"] += count

func delete_item(item_id: int, count: int = 1) -> void:
	if !inventory.has(item_id):
		push_error("CUSTOM: Trying to remove an item that doesn't exist inside of the inventory")
	else:
		if inventory[item_id]["count"] <= count:
			inventory.erase(item_id)
		else:
			inventory[item_id]["count"] -= count

func clear_item(item_id: int) -> void:
	inventory.erase(item_id)

func clear_inventory() -> void:
	inventory.clear()
