extends Node2D

@onready var orb_area: HitboxComponent

@export var speed = 250
var direction: Vector2
var output_damage = 4

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func fire(target):
	#print("Firing Bullet from " + str(self.global_position) + " to " + str(target))
	direction = self.global_position.direction_to(target)


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = output_damage
		
		print("hit")
		hitbox.damage(attack)
		
		queue_free()
