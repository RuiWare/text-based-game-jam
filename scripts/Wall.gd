extends StaticBody2D

class_name Wall

@export var id : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if id in global.solved:
		self.queue_free()

func _on_game_puzzle(value: bool, wall: int):
	pass
