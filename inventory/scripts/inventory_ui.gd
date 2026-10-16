extends Control

@onready var slots: Array = $itemGrid.get_children()
@onready var hotslots: Array = $hotbarGrid.get_children()
var i: int = 0
var alreadyInInv: bool = false

func _ready() -> void:
	GameManager.item_loader = itemLoader.new()
	GameManager.item_loader.load_item()
	GameManager.inventory = inv.new()
	GameManager.inventory.add_item(0, 67)
	GameManager.inventory.add_item(1, 10)
	update_inventory()
	hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("tab"):
		if GameManager.alrInMenu:
			return
		if self.visible:
			get_tree().paused = false
			hide()
		else:
			get_tree().paused = true
			show()

	if Input.get_current_cursor_shape() == CURSOR_FORBIDDEN:
		DisplayServer.cursor_set_shape(DisplayServer.CURSOR_ARROW)

func update_inventory() -> void:
	for key in GameManager.inventory.inventory.keys():
		var item: invItem = GameManager.item_loader.get_item(key)
		var count: int = GameManager.inventory.inventory[key]["count"]
		var texture: Texture2D = item.get_texture()
		for slot in slots:
			if texture == slot.get_child(1).texture:
				slot.update(item, count, texture)
				alreadyInInv = true
				break
		for slot in hotslots:
			if texture == slot.get_child(1).texture:
				slot.update(item, count, texture)
				alreadyInInv = true
				break
		if not alreadyInInv:
			for slot in slots:
				if slot.get_child(1).texture == null:
					slot.update(item, count, texture)
					break
		alreadyInInv = false
		i += 1
	i = 0

var data_bk

func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_bk:
				data_bk["sourceSlot"].sprite.show()
				data_bk["sourceSlot"].label.show()
				data_bk = null
