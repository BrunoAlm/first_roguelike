extends CharacterBody2D

#@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

@export var speed: int = 2
@export_range(0, 1) var lerp_factor: float = 0.5

var is_running: bool = false
var is_attacking: bool = false

func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var target_velocity: Vector2 = direction * speed * 100.0
	velocity = lerp(velocity, target_velocity, lerp_factor)
	
	# Girar Sprite
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
	
	# Atualiza is_running
	var was_running = is_running
	is_running = not direction.is_zero_approx()
	
	# Troca animação
	if was_running != is_running:
		if is_running:
			animation_player.play("run")
		else:
			animation_player.play("idle")
	
	#if Input.is_action_pressed("attack"):
		#animation_player.animation = "attack"

	move_and_slide()
