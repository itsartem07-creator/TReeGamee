extends CharacterBody2D

var chase = false
@export var speed := 100.0

@onready var player: Node2D = $"../../Player/Player"

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = (player.position - position).normalized()
	
	if chase:
		velocity.x = direction.x * speed
	else:
		velocity.x = 0
	
	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true


func _on_detector_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
	chase = false
