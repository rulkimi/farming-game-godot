extends Node2D

@onready var tile_map : TileMap = $TileMap
#@onready var player : CharacterBody2D = $player

func _ready():
	print(tile_map)

func _on_player_tool_used(position: Vector2, tool: String):
	if tool == "hoe":
		var tile_map_pos : Vector2i = tile_map.local_to_map(position)
		tile_map.set_cell(5, tile_map_pos, 9, Vector2i(0, 0)) 
