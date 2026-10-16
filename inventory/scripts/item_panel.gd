extends Panel

@onready var sprite: TextureRect = $emptyItemSprite
@onready var label: Label = $itemQuantity

func update(item: invItem, quantity: int, texture: Texture2D) -> void:
	if item:
		sprite.visible = true
		label.visible = true
		sprite.texture = texture
		label.text = "x" + str(quantity)
	else:
		sprite.visible = false

#func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	#if Input.is_action_pressed("mousewheel") and !sprite.texture:
		#sprite.texture = data["texture"]
		#label.text = "x1"
	#return true

func _get_drag_data(_at_position: Vector2) -> Variant:
	if sprite.texture == null:
		return
	
	var preview = duplicate()
	var control = Control.new()
	control.add_child(preview)
	preview.position -= Vector2(50, 50)
	preview.self_modulate = Color.TRANSPARENT
	control.modulate = Color(control.modulate, 0.5)
	
	set_drag_preview(control)
	sprite.hide()
	label.hide()
	return {
		"sourceSlot": self,
		"texture": sprite.texture,
		"quantity": label.text,
		"n": int(label.text)
	}

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if Input.is_action_pressed("mousewheel") and !sprite.texture and data["n"] > 0:
		sprite.texture = data["texture"]
		label.text = "x1"
		data["n"] -= 1
		data["quantity"] = "x" + str(data["n"])
		#preview.get_child(2).text = "x" + str(int(preview.get_child(2).text) - update_item_count(1, preview.get_child(2)))
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var sourceSlot = data["sourceSlot"]
	if data["n"] == 0:
		sprite.texture = null
		label.text = ""
		return
	if sprite.texture == data["texture"]: ## make two same items combine into one item, adding up the quantity!
		sprite_replacement(sourceSlot, true)
	if $emptyItemSprite.texture:
		sprite_replacement(sourceSlot, false)
		apply_sprite(data)
		return
	apply_sprite(data)
	if self == data["sourceSlot"]:
		return
	sprite_replacement(sourceSlot, true)

func sprite_replacement(sourceSlot: Panel, isNull: bool) -> void:
	if !isNull:
		sourceSlot.sprite.texture = sprite.texture
		sourceSlot.label.text = label.text
		sourceSlot.sprite.show()
		sourceSlot.label.show()
	else:
		sourceSlot.sprite.texture = null
		sourceSlot.label.text = ""
		sourceSlot.sprite.hide()
		sourceSlot.label.hide()

func apply_sprite(data: Variant) -> void:
	sprite.texture = data["texture"]
	label.text = data["quantity"]
	data.texture = sprite.texture
	sprite.show()
	label.show()

func update_item_count(subtrahend: int, l: Node) -> int:
	var n = int(l.text)
	return n - subtrahend
