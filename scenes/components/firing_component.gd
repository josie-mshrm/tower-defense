extends Node2D
# This component creates and fires bullets

@export var fire_freq: float = 0.2


const orbs = preload("res://scenes/orbs.tscn")
@onready var fire_rate: Timer = $"fire rate"
@onready var orb_holder: Node2D = $/root/main/OrbHolder


var is_firing = false
var orb_target


func _process(delta: float) -> void:
	if fire_rate.is_stopped() == true and is_firing == true: # if the timer is not currently running and the fire button is being held
		fire_rate.start(fire_freq) # start the firing timer
	elif is_firing == false: # if the timer is running OR the firing button is not being held
		fire_rate.stop() # stop the timer

func enable_fire(target):
	orb_target = target
	is_firing = true

func disable_fire():
	is_firing = false


func _on_fire_rate_timeout() -> void:
	fire_bullet(orb_target)


func fire_bullet(orb_target):
	var orb_inst = orbs.instantiate()
	orb_holder.add_child(orb_inst)
	orb_inst.global_position = self.global_position
	orb_inst.fire(orb_target)
