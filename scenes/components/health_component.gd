extends Node

class_name HealthComponent

@export var max_health: int

var health: float

func _ready() -> void:
	health = max_health

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		print("death")
		get_parent().queue_free()
