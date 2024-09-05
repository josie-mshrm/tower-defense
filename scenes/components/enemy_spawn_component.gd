extends Node2D

const enemy_basic = preload("res://scenes/enemy_basic.tscn")

@onready var orb_holder: Node2D = $/root/main/OrbHolder
@onready var enemy_holder: Node2D = $/root/main/EnemyHolder
@onready var spawn_timer: Timer = $spawn_timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start()
	print("start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	
func spawn_enemy():
	var enemy = enemy_basic.instantiate()
	enemy_holder.add_child(enemy)
	enemy.global_position = self.global_position
	print("enemy spawned")
