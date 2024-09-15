class_name Tower
extends StaticBody2D

@export var tower_range: int

@export var base: CollisionShape2D
@export var top_shape: CollisionPolygon2D
@export var range_cmp: RangeComponent
@export var firing_component: FiringComponent

var target: Node2D
var targets_inrange: Array
var target_position: Vector2
var angle: float

var index: int

## A signal to notify the attached components that a target has been found, and provide it's position
signal target_found(target: Soul)
signal rotation_changed(angle)

func _ready() -> void:
	range_cmp.body_entered.connect(on_range_body_entered)
	range_cmp.body_exited.connect(on_range_body_exited)
	
	#to come back and fix later
	#range_cmp.range = tower_range * 10

func _physics_process(delta: float) -> void:
	cleanup_targets() # clear the array of targets
	
	if has_target(): # if there is a target
		target = targets_inrange[0] # set the target to the first array index (first target to have entered)
		target_position = target.global_position # set the target position
		target_found.emit(target) # emit the target found signal
		
		rotate_tower(target_position)
	else: # if there is no target
		firing_component.disable_fire() #disable the fire


func on_range_body_entered(body: CharacterBody2D) -> void:
	if body is Soul:
		targets_inrange.append(body) # adds the body that entered to the array
		
	#index = targets_inrange.size()
	#print("enter: " + str(index))


func on_range_body_exited(body: CharacterBody2D) -> void:
	if body is Soul:
		targets_inrange.erase(body) # removes the body that exited from the array
	#index = targets_inrange.size()
	#print("exit: " + str(index))
		#print("erase")
	#else:
		#print("Not a soul")


## Determines whether or not the first element is a valid target. Returns true if there is a target.
func has_target() -> bool:
	if targets_inrange.is_empty():
		return false
	else:
		return true

## Checks if the target array's first slot is empty, if it is clear it, if it's not stop.
## This will clear out targets that have died, since they won't exit the area.
func cleanup_targets():
	while not targets_inrange.is_empty():
		var first_target: Node = targets_inrange.front()
		if first_target.is_inside_tree():
			break
		else:
			targets_inrange.pop_front()

func rotate_tower(t_position):
	angle = get_angle_to(t_position)
	top_shape.set_rotation(angle)
	rotation_changed.emit(angle)
