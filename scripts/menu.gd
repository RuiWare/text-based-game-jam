extends Control

@export var dest_scene : String

#var audio : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()
	print("start")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	play_sound($Press_SFX)
	get_tree().change_scene_to_file(dest_scene)
	
func _on_play_mouse_entered() -> void:
	play_sound($Hover_SFX)

func _on_options_pressed() -> void:
	play_sound($Press_SFX)

func _on_options_mouse_entered() -> void:
	play_sound($Hover_SFX)
	
func _on_quit_pressed() -> void:
	play_sound($Press_SFX)
	get_tree().quit()

func _on_quit_mouse_entered() -> void:
	play_sound($Hover_SFX)

func play_sound(sfx: AudioStreamPlayer):
	randomize()
	sfx.pitch_scale = randf_range(0.8, 1.2)
	sfx.play()
	
