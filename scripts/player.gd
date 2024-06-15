extends CharacterBody2D

const SPEED = 100
const BOOSTED_SPEED = SPEED + 100
@export var speed = SPEED
@export var tools = TOOLS

var using_tool = false
var current_tool = "hoe"
var is_moving = false
var current_direction = "down"

const TOOLS = {"tool_1": "axe", "tool_2": "hoe", "tool_3": "watering-pot"}
const DIRECTIONS = {"ui_right": Vector2(1, 0), "ui_left": Vector2(-1, 0), "ui_down": Vector2(0, 1), "ui_up": Vector2(0, -1)}

func _ready():
	$AnimatedSprite2D.play("front_idle")
	$AnimatedSprite2D.connect("animation_finished", _on_AnimatedSprite2D_animation_finished)

func _physics_process(delta):
	handle_speed_input()
	handle_movement_input()
	handle_tool_input()
	handle_tool_usage()
	move_and_slide()
	
func handle_speed_input():
	if Input.is_action_just_pressed("ui_shift"):
		speed = BOOSTED_SPEED
	elif Input.is_action_just_released("ui_shift"):
		speed = SPEED
		
func handle_movement_input():
	if !using_tool:
		for action in DIRECTIONS.keys():
			if Input.is_action_pressed(action):
				is_moving = true
				current_direction = action.replace("ui_", "")
				$AnimatedSprite2D.flip_h = (action == "ui_left")
				velocity = DIRECTIONS[action] * speed
				$AnimatedSprite2D.play(get_animation(current_direction) + "_walk")
				return
	stop_moving()

func handle_tool_input():
	for tool_action in TOOLS.keys():
		if Input.is_action_pressed(tool_action):
			current_tool = TOOLS[tool_action]
			$AnimatedSprite2D.frame = 0
			$AnimatedSprite2D.play("front" + "_" + current_tool)
			return

func handle_tool_usage():
	if Input.is_action_just_pressed("use_tool") and !is_moving:
		using_tool = true
		$AnimatedSprite2D.flip_h = (current_direction == "left")
		$AnimatedSprite2D.play(get_animation(current_direction) + "_" + current_tool)

func stop_moving():
	if !using_tool:
		is_moving = false
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play(get_animation(current_direction) + "_idle")

func _on_AnimatedSprite2D_animation_finished():
	if $AnimatedSprite2D.animation == get_animation(current_direction) + "_" + current_tool:
		using_tool = false
	else:
		is_moving = false

func get_animation(direction):
	match direction:
		"right":
			$AnimatedSprite2D.flip_h = false
			return "side"
		"left":
			$AnimatedSprite2D.flip_h = true
			return "side"
		"down":
			return "front"
		"up":
			return "back"
	return "front"
