extends Node2D

var Enemy = preload("res://enemy.tscn") 

@onready var spawn_timer = $SpawnTimer
@onready var platform = $Ship  

var spawn_height_offset = 1000  # Fixed height above the platform where enemies will spawn

func _ready() -> void:
	spawn_timer.connect("timeout", spawn_enemy)
	spawn_timer.start()


func spawn_enemy():
	var enemy = Enemy.instantiate()
	
	var platform_y_position = platform.position.y
	
	var spawn_x_position = randf_range(0, get_viewport().size.x)  # Random X position within the viewport
	var spawn_y_position = platform_y_position - spawn_height_offset  # Fixed Y position above the platform
	
	enemy.position = Vector2(spawn_x_position, spawn_y_position)
	add_child(enemy)
