extends CharacterBody2D

class_name Player

const tile_size = 16
var moving = false
var input_dir
var has_bumped = false

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var ray_cast_2d = $RayCast2D
@onready var camera = $"../Camera2D"


func _ready():
	$AnimatedSprite2D.play("side idle")

func _physics_process(delta: float) -> void:
	if global.is_dialogue == true:
		return
	
	current_camera()
	if moving:
		return
	#input_dir = Vector2.ZERO
	
	if Input.is_action_just_released("ui_accept") and ray_cast_2d.is_colliding():
		print("Interacted")
		var collider = $RayCast2D.get_collider()
		collider._on_interact()
	
	if Input.is_action_pressed("ui_up"):
		input_dir = Vector2.UP
		play_anim(1)
		move()
	elif Input.is_action_pressed("ui_down"):
		input_dir = Vector2.DOWN
		play_anim(1)
		move()
	elif Input.is_action_pressed("ui_left"):
		input_dir = Vector2.LEFT
		play_anim(1)
		move()
	elif Input.is_action_pressed("ui_right"):
		input_dir = Vector2.RIGHT
		play_anim(1)
		move()
	else:
		play_anim(0)
	
	global.player_posx = position.x
	global.player_posy = position.y
	global.player_side = input_dir
	
	move_and_slide()
			
func move():
	var current_tile: Vector2i = tile_map_layer.local_to_map(global_position)
	
	var target_tile: Vector2i = Vector2i (
		int(current_tile.x + input_dir.x),
		int(current_tile.y + input_dir.y)
	)
	
	var tile_data: TileData = tile_map_layer.get_cell_tile_data(target_tile)
	
	ray_cast_2d.target_position = input_dir * 16
	ray_cast_2d.force_raycast_update()
	
	if ray_cast_2d.is_colliding():
		return
	
	if input_dir:
		if tile_data.get_custom_data("walkable") == true:
			if moving == false:
				has_bumped = false
				moving = true
				#var tween = create_tween()
				#tween.tween_property(self, "position", position + input_dir * tile_size, 0.25)
				#tween.tween_callback(move_false)
				#global_position = tile_map_layer.map_to_local(target_tile)
				var tween = create_tween()
				tween.tween_property(self, "position", position + input_dir * tile_size, 0.3)
				randomize()
				$Steps.pitch_scale = randf_range(0.8, 3)
				$Steps.play()
				tween.tween_callback(move_false)
		else:
			if (has_bumped == false):
				randomize()
				$"../Stop SFX".pitch_scale = randf_range(0.8, 1.2)
				$"../Stop SFX".play()
				
				has_bumped = true
			
func move_false():
	moving = false

func play_anim(movement):
	var dir = input_dir
	var anim = $AnimatedSprite2D
	
	if dir == Vector2.RIGHT:
		anim.flip_h = true
		if movement == 1:
			anim.play("side run")
		elif movement == 0:
			anim.play("side idle")
	
	if dir == Vector2.LEFT:
		anim.flip_h = false
		if movement == 1:
			anim.play("side run")
		elif movement == 0:
			anim.play("side idle")
	
	if dir == Vector2.UP:
		if movement == 1:
			anim.play("backward run")
		elif movement == 0:
			anim.play("backward idle")
			
	if dir == Vector2.DOWN:
		if movement == 1:
			anim.play("forward run")
		elif movement == 0:
			anim.play("forward idle")
	
	
#func player():
	#pass

func current_camera():
	var camera_tween = create_tween()
	camera_tween.tween_property(camera, "position", camera.camera_pos_dic[global.camera_move], 0.1)
		
