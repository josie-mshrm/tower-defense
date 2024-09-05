extends Enemy

var force_direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	apply_central_force(force_direction)


#func _on_movement_component_directional_movement(direction: Variant) -> void:
	#
	#if direction != Vector2.ZERO:
		#force_direction = direction
	#else:
		#force_direction = Vector2.ZERO
