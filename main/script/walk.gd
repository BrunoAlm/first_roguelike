extends CharacterBody2D

@onready var sprites = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isJumping = false
var isAttacking = false

func _physics_process(delta):
	if not is_on_floor():
		sprites.play("jump")
		velocity.y += gravity * delta
	else:
		var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY

		if Input.is_action_pressed("attack"):
			isAttacking = true
		else:
			isAttacking = false

		if direction != 0:
			if isAttacking:
				sprites.play("attack")
			else:
				sprites.play("run")
			velocity.x = direction * SPEED
		else:
			if isAttacking:
				sprites.play("attack")
			else:
				sprites.play("idle")
			velocity.x = 0

		if direction < 0:
			sprites.scale.x = -1
		elif direction > 0:
			sprites.scale.x = 1

	move_and_slide()
