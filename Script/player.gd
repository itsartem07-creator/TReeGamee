extends CharacterBody2D

enum {
	DOWN,
	UP,
	LEFT,
	RIGHT
}

@onready var anim = $AnimatedSprite2D
var speed = 100
var sprint_multiplier = 2.0
var idle_dir = DOWN

func _physics_process(delta: float) -> void:
	var current_speed = speed
	if Input.is_action_pressed("sprint"):
		current_speed = speed * sprint_multiplier

	if Input.is_action_pressed("up"):
		up_move(current_speed)
	elif Input.is_action_pressed("down"):
		down_move(current_speed)
	elif Input.is_action_pressed("left"):
		left_move(current_speed)
	elif Input.is_action_pressed("right"):
		right_move(current_speed)
	else:
		idle()

	move_and_slide()

func up_move(spd):
	anim.play("Up")
	velocity.x = 0
	velocity.y = -spd
	idle_dir = UP

func down_move(spd):
	anim.play("Down")
	velocity.x = 0
	velocity.y = spd
	idle_dir = DOWN

func left_move(spd):
	anim.flip_h = true
	anim.play("Run")
	velocity.x = -spd
	velocity.y = 0
	idle_dir = LEFT

func right_move(spd):
	anim.flip_h = false
	anim.play("Run")
	velocity.x = spd
	velocity.y = 0
	idle_dir = RIGHT

func idle():
	velocity.x = 0
	velocity.y = 0
	match idle_dir:
		DOWN:
			anim.play("Idle")
		UP:
			anim.play("Idle_Up")
		LEFT:
			anim.flip_h = true
			anim.play("Idle_Front")
		RIGHT:
			anim.flip_h = false
			anim.play("Idle_Front")
