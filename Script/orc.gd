extends CharacterBody2D

var chase = false
@export var speed := 100.0

@onready var player: Node2D = null
@onready var anim = $AnimatedSprite2D

var alive = true

func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	else:
		player = get_node_or_null("../../Player")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player == null:
		velocity.x = 0
		anim.play("Idle")
		move_and_slide()
		return

	var direction = (player.position - position).normalized()
	if alive == true:
		if chase == true:
			velocity.x = direction.x * speed
			anim.play("Run")
		else:
			velocity.x = 0
			anim.play("Idle")
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true

func _on_detector_body_exited(body: Node2D) -> void:
	chase = false

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if "velocity" in body:
			body.velocity.y -= 200
		death()

func _on_death_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if alive == true:
			if "health" in body:
				body.health -= 40
		death()

func death():
	if not alive:
		return
	alive = false
	anim.play("Death")
	await anim.animation_finished
	queue_free()
