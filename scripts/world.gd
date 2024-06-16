extends Node2D

@onready var tile_map : TileMap = $TileMap
@onready var tool_area : Area2D = $ToolArea
#@onready var player : CharacterBody2D = $player

func _ready():
	print(tile_map)

func _on_player_tool_used(tool_position: Vector2, tool: String):
	var tile_map_pos: Vector2i = tile_map.local_to_map(tool_position)
	
	if Global.entered_tool_area:
		if tool == "hoe" and tile_map.get_cell_atlas_coords(5, tile_map_pos) != Vector2i(0, 0):
			tile_map.set_cell(5, tile_map_pos, 12, Vector2i(0, 0))
		elif tool == "watering-pot":
		# Check if the current tile is hoed
			if tile_map.get_cell_atlas_coords(5, tile_map_pos) == Vector2i(0, 0):
				tile_map.set_cell(5, tile_map_pos, 11, Vector2i(0, 0))

