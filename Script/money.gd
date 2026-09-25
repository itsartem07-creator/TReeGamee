extends Node2D

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("Idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	queue_free()
