extends CharacterBody2D

const SPEED = 300.0
var is_holding_object = false
@export var objectType = "player"

func _physics_process(delta):

	# Direction du player
	var directionX = Input.get_axis("left", "right")
	var directionY = Input.get_axis("up", "down")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	# Rotation du sprite et garde la position
	if velocity.x != 0 or velocity.y != 0:
		rotation = atan2(velocity.x,velocity.y)
		$AnimatedSprite2D.play("walking")
	else:
		$AnimatedSprite2D.play("default")
	move_and_slide()
