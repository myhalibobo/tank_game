extends Node

var tile_size = Vector2(128,128)
onready var texture = $Sprite.texture

func _ready():
	var tex_width = texture.get_width()
	var tex_height = texture.get_height()
	var col = tex_width / tile_size.x
	var row = tex_height / tile_size.y
	var ts = TileSet.new()
	
	for r in range(row):
		for l in range(col):
			var id = l + (r*col)
			print(id)
			var region = Rect2(r * tile_size.x,l * tile_size.y,
				tile_size.x,tile_size.y)
			ts.create_tile(id)
			ts.tile_set_texture(id , texture)
			ts.tile_set_region(id, region)
	ResourceSaver.save("res://terrain/terrain_tiles.tres",ts)