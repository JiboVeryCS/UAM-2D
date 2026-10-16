class_name shop

var shopItems: Array[int]

func add_to_shop(craftID: int) -> void:
	if not shopItems.has(craftID):
		shopItems.append(craftID)
	else:
		print(craftID, " Already in shop. Nothing to do.")
