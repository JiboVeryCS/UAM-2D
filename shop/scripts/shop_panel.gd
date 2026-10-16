extends Panel

var occupied: bool = false
var c: craftingItem

func update(craft: craftingItem, texture: Texture2D) -> void:
	c = craft
	$itemTexture.texture = texture
	$itemName.text = craft.itemName
	$points.text = str(craft.points) + "pts."
	occupied = true

func _on_button_pressed() -> void:
	if c != null:
		get_parent().get_parent().get_parent().update_display(c, $itemTexture.texture)
