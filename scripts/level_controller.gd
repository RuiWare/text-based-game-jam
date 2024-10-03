extends Node

signal puzzle(value: bool, wall: int)

signal reset(value: int)

@export_file var dest_scene
var win_condition = false

var answer_1 = [1]
var player_answer_1 = []

var answer_2 = [3, 1, 2]
var player_answer_2 = []



var answer_3 = {
	1: true,
	2: false,
	3: true
}
var player_answer_3 = {}

var last_player_dir = Vector2.ZERO
var camera_incremented = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(get_tree().current_scene)
	#EventController.connect("interacted", _level_switch())
	$Music.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process (_delta):
	_level_switch()
	
func _puzzle_setup (puzzle: int, value: int, state: bool):
	if puzzle == 1:
		pass
	elif puzzle == 2:
		pass
	elif puzzle == 3:
		_puzzle_check(puzzle, value, state)
		

func _remove_input(puzzle: int, value: int):
	if puzzle == 1:
		player_answer_1.remove_at(player_answer_1.find(value))
	elif puzzle == 2:
		player_answer_2.remove_at(player_answer_2.find(value))
	print("removed")

func _puzzle_check(puzzle: int, value: int, state: bool):
	if puzzle == 1:
		player_answer_1.append(value)
		if (player_answer_1.size() == answer_1.size()):
			for n in answer_1.size():
				if player_answer_1[n] != answer_1[n]:
					player_answer_1.clear()
					emit_signal("reset", 1)
					return
			#emit_signal("puzzle", true, 1)
			global.solved.append(1)
			randomize()
			$PuzzleSFX.pitch_scale = randf_range(0.8, 5)
			$PuzzleSFX.play()
		#print("Emitted")
	elif puzzle == 2:
		player_answer_2.append(value)
		if (player_answer_2.size() == answer_2.size()):
			for n in answer_2.size():
				if player_answer_2[n] != answer_2[n]:
					player_answer_2.clear()
					emit_signal("reset", 2)
					return
			#emit_signal("puzzle", true, 1)
			global.solved.append(2)
			randomize()
			$PuzzleSFX.pitch_scale = randf_range(0.8, 5)
			$PuzzleSFX.play()
		#print("Emitted")
	elif puzzle == 3:
		player_answer_3[value] = state
		if (player_answer_3.size() == answer_3.size()):
			for key in answer_3.keys():
				if player_answer_3[key] != answer_3[key]:
					return
			#emit_signal("puzzle", true, 2)
			global.solved.append(3)
			randomize()
			$PuzzleSFX.pitch_scale = randf_range(0.8, 5)
			$PuzzleSFX.play()
			#print("Emitted 2")

func _level_switch():
	if (win_condition):
		get_tree().change_scene_to_file(dest_scene)


func _on_area_2d_body_entered(body):
	if body is Player:		
		if global.player_side == Vector2.RIGHT && camera_incremented == false:
			last_player_dir == Vector2.RIGHT
			global.camera_move += 1
			print(global.camera_move)
			camera_incremented = true
		print("test")


func _on_area_2d_body_exited(body):
	if body is Player:
		if global.player_side == Vector2.LEFT:
			last_player_dir == Vector2.LEFT
			global.camera_move -= 1
			print(global.camera_move)
		camera_incremented = false
		print("exittest")
