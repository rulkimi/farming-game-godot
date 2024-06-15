extends CharacterBody2D

var speed = 100

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("side_walk")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = 0
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("side_walk")
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = speed
		$AnimatedSprite2D.play("front_walk")
	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -speed
		$AnimatedSprite2D.play("back_walk")


