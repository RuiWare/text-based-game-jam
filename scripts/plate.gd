extends Area2D

@export var puzzle_id : int
@export var solution : int
@export var collider : CollisionShape2D
@export var is_active : bool

@onready var controller = $".."

func _ready():
	controller._puzzle_setup (puzzle_id, solution, is_active)

func _physics_process(delta):
	play_anim(is_active)
	

func play_anim(toggle):
	var anim = $AnimatedSprite2D
	if toggle == false:
		anim.play("Idle")
	elif toggle == true:
		anim.play("Interacted")

#func _on_interact():
	#print("Object recieves")
	#controller._item_interacted_1(solution)
	## self.queue_free()

func _on_body_entered(body):
	if puzzle_id in global.solved:
		return
	print("test")
	if body is Player:		
		is_active = !is_active
		controller._puzzle_setup (puzzle_id, solution, is_active)
		print("plate")


func _on_body_exited(body):
	if puzzle_id in global.solved:
		return
	if body is Player:
		print("no plate")
