extends Node

var tile_size = Vector2(16, 16)
var entered_tool_area = false

func get_tile_size() -> Vector2:
	return tile_size

func tool_area_entered():
	entered_tool_area = true

func tool_area_exited():
	entered_tool_area = false
