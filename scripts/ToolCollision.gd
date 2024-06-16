extends Area2D

@onready var tool_collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_tool_area_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
	Global.tool_area_entered()


func _on_tool_area_area_shape_exited(_area_rid, _area, _area_shape_index, _local_shape_index):
	Global.tool_area_exited()
