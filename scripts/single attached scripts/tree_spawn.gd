extends Area2D

@onready var tilemap: TileMapLayer = get_node("/root/testScene/Map/MainMap")
var tree_scene: PackedScene = preload("res://scenes/objects/big_tree.tscn")
var a: Vector2
var b: Vector2
var tile_data
var zIndex: int = 0
var noise: Noise
var texture: NoiseTexture2D
var gradient: Gradient

func _ready() -> void:
	gradient = Gradient.new()
	gradient.add_point(0.2, Color.BLACK)
	gradient.add_point(1.0, Color.WHITE)
	
	noise = FastNoiseLite.new()
	noise.seed = randi_range(0, 99999)
	noise.frequency = 0.005
	
	texture = NoiseTexture2D.new()
	texture.noise = noise
	texture.color_ramp = gradient

	
	var shapeNode: CollisionShape2D = get_node("/root/testScene/TreeSpawn/TestCollision")
	var RectangleShape: RectangleShape2D = shapeNode.shape
	a = shapeNode.global_position - RectangleShape.size / 2
	b = shapeNode.global_position + RectangleShape.size / 2
	
	for cell in tilemap.get_used_cells():
		tile_data = tilemap.get_cell_tile_data(cell)
		if tile_data == null: continue
		if tile_data.get_custom_data("canSpawnTree"):
			var world_pos = tilemap.map_to_local(cell)
			spawn_tree(world_pos, tree_spawn_chance(cell))
		
	
	var trees = get_node("../environment").get_children()
	
	trees.sort_custom(func(f, g):
		return f.global_position.y < g.global_position.y)
	
	for tree in trees:
		tree.z_index = zIndex
		zIndex += 1

func spawn_tree(pos: Vector2, chance: float) -> void:
	if randf_range(0, 100) > chance : return
	var tree: Node2D = tree_scene.instantiate()
	tree.global_position = pos
	get_node("../environment").add_child(tree)

func tree_spawn_chance(pos: Vector2) -> float:
	var n = noise.get_noise_2d(pos.x, pos.y)
	return remap(n, -1, 1, 0.05, 0.9)
