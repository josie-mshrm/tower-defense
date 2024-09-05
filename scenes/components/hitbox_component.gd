extends Area2D
class_name HitboxComponent
# This component takes damage and applies it to the health component

@export var health: HealthComponent

func damage(attack: Attack):
	if health is HealthComponent:
		health.damage(attack)
