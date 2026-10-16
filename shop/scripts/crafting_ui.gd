extends Control

@onready var panels: Array = $ScrollContainer/VBoxContainer.get_children()
@onready var containers: Array[ColorRect] = [$TopLeft, $TopRight, $BottomLeft, $BottomRight]
var arrayCheck: Array[bool]

func _ready() -> void:
	$craftButton.disabled = true
	GameManager.craft_loader = itemLoader.new()
	GameManager.craft_loader.load_crafts()
	GameManager.crafts = shop.new()
	GameManager.crafts.add_to_shop(0)
	GameManager.crafts.add_to_shop(1)
	update_shop()

func update_shop() -> void:
	for i in GameManager.crafts.shopItems:
		var item: craftingItem = GameManager.craft_loader.get_craft(i)
		var texture: Texture2D = item.get_texture()
		for p in panels:
			if !p.occupied:
				p.update(item, texture)
				break

func update_display(craft: craftingItem, texture: Texture2D) -> void:
	for rect in containers:
		if rect.get_child(0).texture != null:
			rect.get_child(0).texture = null
			rect.get_child(1).text = ""
	$itemBgColor/itemTexture.texture = texture
	for i in range(4):
		if craft.rDict["ID"][i] < 0:
			break
		var item = GameManager.item_loader.get_item(craft.rDict["ID"][i])
		for rect in containers:
			if rect.get_child(0).texture == null:
				rect.get_child(0).texture = load(item.texture)
				rect.get_child(1).text = item.itemName + " x" + str(craft.rDict["n"][i])
				break
		#if (GameManager.inventory.inventory.has(craft.rDict["ID"][i]) and 
		#GameManager.inventory.inventory[craft.rDict["ID"][i]]["count"] >= craft.rDict["n"][i]):
			#pass

#func _on_craft_button_pressed() -> void:
	#for i in range(4):
		#var item = GameManager.item_loader.get_item(craft.rDict["ID"][i])
		#if GameManager.inventory.inventory.has(craft.rDict["ID"][i]):
			#pass
