extends CharacterBody2D  # Change from RigidBody2D to CharacterBody2D

@export var speed: float = 500  
@export var detection_radius: float = 500.0  
@export var gravity: float = 981.0

var player: Node2D = null

func _ready():
	player = get_node("/root/World/Player")  # Adjust this path to match your scene structure
	add_to_group("enemies") 


func _physics_process(_delta):
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player <= detection_radius:
			var direction = (player.global_position - global_position).normalized()
			velocity.x = direction.x * speed 

	if !is_on_floor():
		velocity.y += gravity * _delta  # Apply gravity only when not on the ground
	else:
		velocity.y = 0  # Reset vertical velocity when on the ground

	move_and_slide()  # Call move_and_slide with velocity

func _on_body_entered(body):
	if body == player:
		print("Hit the player!")
