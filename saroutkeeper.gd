extends CharacterBody2D

@export_category("Arcade Movement Settings")
@export var SPEED: float = 350.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var last_direction := "down"

func _physics_process(_delta: float) -> void:

	var input_direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	if input_direction != Vector2.ZERO:
		velocity = input_direction.normalized() * SPEED

		if abs(input_direction.x) > abs(input_direction.y):
			last_direction = "side"
			animated_sprite_2d.flip_h = input_direction.x < 0
		else:
			animated_sprite_2d.flip_h = false

			if input_direction.y < 0:
				last_direction = "up"
			else:
				last_direction = "down"

		animated_sprite_2d.play("walk_" + last_direction)

	else:
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle_" + last_direction)

	move_and_slide()
