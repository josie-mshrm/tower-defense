class_name Orb
extends Node2D

@onready var orb_area: HitboxComponent

@export var speed: int
var direction: Vector2
var orb_target
var output_damage = 4

func _physics_process(delta: float) -> void:
	direction = find_target_direction()
	
	position += direction * speed * delta

func fire(target: Soul):
	if target == null:
		return
	
	if target.is_queued_for_deletion: # if the target is not already queued to be deleted
		orb_target = target
		#print("Firing Bullet from " + str(self.global_position) + " to " + str(target))
	else:
		orb_target = null

func find_target_direction() -> Vector2:
	var target_direction: Vector2
	var target_pos: Vector2
	if orb_target == null:
		target_direction = Vector2.RIGHT
	else:
		target_pos = orb_target.global_position
		target_direction = self.global_position.direction_to(target_pos)
	
	return target_direction

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = output_damage
		
		print("hit")
		hitbox.damage(attack)
		
		queue_free()
