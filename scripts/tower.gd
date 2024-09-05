extends StaticBody2D

@onready var top_shape: CollisionPolygon2D = $"top shape"
@onready var tower_range: Area2D = $"tower-range"
@onready var firing_component: Node2D = $"top shape/firing_component"

var target: Node2D
var targets_inrange: Array
var target_position
var angle
var n: int = 0


func _physics_process(delta: float) -> void:
	cleanup_targets()
	
	if has_target():
		track_enemy()
		firing_component.enable_fire(target_position)
	else:
		firing_component.disable_fire()


func _on_towerrange_body_entered(body: CollisionObject2D) -> void:
	if body is Enemy:
		targets_inrange.append(body) # adds the body that entered to the array


func _on_towerrange_body_exited(body: CollisionObject2D) -> void:
	if body is Enemy:
		targets_inrange.erase(body)


## Determines whether or not the first element is a valid target.
func has_target():
	return not targets_inrange.is_empty()


func cleanup_targets():
	while not targets_inrange.is_empty():
		var first_target: Node = targets_inrange.front()
		if first_target.is_inside_tree():
			break
		else:
			targets_inrange.pop_front()


func track_enemy():
	target_position = targets_inrange[0].global_position
	angle = get_angle_to(target_position)
	top_shape.set_rotation(angle)
