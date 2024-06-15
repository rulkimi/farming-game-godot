extends CharacterBody2D

var speed = 100

var using_tool = false
var current_tool = "shovel"

var is_moving = false
var current_direction = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)
	$AnimatedSprite2D.connect("animation_finished", _on_AnimatedSprite2D_animation_finished)
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right") and !using_tool:
		is_moving = true
		current_direction = "right"
		velocity.x = speed
		velocity.y = 0
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("side_walk")
	elif Input.is_action_pressed("ui_left") and !using_tool:
		is_moving = true
		current_direction = "left"
		velocity.x = -speed
		velocity.y = 0
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("side_walk")
	elif Input.is_action_pressed("ui_down") and !using_tool:
		is_moving = true
		current_direction = "down"
		velocity.x = 0
		velocity.y = speed
		$AnimatedSprite2D.play("front_walk")
	elif Input.is_action_pressed("ui_up") and !using_tool:
		is_moving = true
		current_direction = "up"
		velocity.x = 0
		velocity.y = -speed
		$AnimatedSprite2D.play("back_walk")
	elif Input.is_action_pressed("use_tool") and !is_moving:
		using_tool = true
		if current_direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_" + current_tool)
		elif current_direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_" + current_tool)
		elif current_direction == "down":
			$AnimatedSprite2D.play("front_" + current_tool)
		elif current_direction == "up":
			$AnimatedSprite2D.play("back_" + current_tool)
	elif !using_tool:
		is_moving = false
		velocity.x = 0
		velocity.y = 0
		if current_direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_idle")
		elif current_direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_idle")
		elif current_direction == "down":
			$AnimatedSprite2D.play("front_idle")
		elif current_direction == "up":
			$AnimatedSprite2D.play("back_idle")
		
	move_and_slide()
	
func _on_AnimatedSprite2D_animation_finished():
	if $AnimatedSprite2D.animation == "side_" + current_tool or "back_" + current_tool or "front_" + current_tool:
		using_tool = false
	else:
		is_moving = false


