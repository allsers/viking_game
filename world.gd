extends Node2D

var Enemy = preload("res://enemy.tscn") 

@onready var spawn_timer = $SpawnTimer
@onready var platform = $Ship  
@onready var adjust_timer = $AdjustTimer
@export var spawn_height_offset = 1000  

var initial_wait_time = 3.0
var min_wait_time = 0.5
var time_elapsed = 0.0

func _ready() -> void:
	spawn_timer.wait_time = initial_wait_time
	
	spawn_timer.connect("timeout", spawn_enemy)
	spawn_timer.start()
	adjust_timer.connect("timeout", _on_adjust_timer_timeout)
	adjust_timer.start()

func spawn_enemy():
	var enemy = Enemy.instantiate()
	
	var platform_y_position = platform.position.y
	
	var spawn_x_position = randf_range(0, get_viewport().size.x)  # Random X position within the viewport
	var spawn_y_position = platform_y_position - spawn_height_offset  # Fixed Y position above the platform
	
	enemy.position = Vector2(spawn_x_position, spawn_y_position)
	add_child(enemy)

func _on_adjust_timer_timeout():
	time_elapsed += adjust_timer.wait_time
	var new_wait_time = initial_wait_time - (sin(time_elapsed) * 0.5 + 0.5) * (initial_wait_time - min_wait_time)
	new_wait_time = max(new_wait_time, min_wait_time)
	spawn_timer.wait_time = new_wait_time
