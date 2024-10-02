extends CharacterBody2D

@export var solution : int
@export var puzzle_id : int
@export var collider : CollisionShape2D

@onready var controller = $".."

var is_active = false

func _physics_process(delta):
	play_anim(is_active)

func _on_interact():	
	if puzzle_id not in global.solved && is_active == false:
		is_active = true
		print("Object recieves")
		controller._puzzle_check(puzzle_id, solution, true)
		randomize()
		$"../Interact SFX".pitch_scale = randf_range(0.8, 1.2)
		$"../Interact SFX".play()
		# self.queue_free()
	elif puzzle_id not in global.solved && is_active == true:
		controller._remove_input(puzzle_id, solution)
		is_active = false
		print("changed")
	
		
func play_anim(toggle):
	var anim = $AnimatedSprite2D
	if toggle == false:
		anim.play("off")
	elif toggle == true:
		anim.play("on")


func _on_game_reset(value: int) -> void:
	print("reset")
	if puzzle_id == value:
		is_active = false
