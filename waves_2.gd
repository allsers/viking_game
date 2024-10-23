extends TileMapLayer  # Ensure this is the correct node type for your use case

var bobbing_speed: float = 2.0
var bobbing_amplitude: float = 50
var initial_y_position: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_y_position = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Calculate new Y position using sine wave for smooth bobbing
	position.y = initial_y_position + sin(Time.get_ticks_msec() / 1000.0 * bobbing_speed + 50) * bobbing_amplitude
