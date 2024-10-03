extends Area2D

@export var solution : int
@export var dialogue : String

@onready var controller = $".."

var in_range = false

func _ready() -> void:
	Dialogic.signal_event.connect(dialogue_signal)
	
func _process(delta):
	if Input.is_action_just_released("ui_accept") && in_range && global.is_dialogue == false:
		print("Interacted")
		_on_interact()

func _on_interact():
	print("Object recieves")
	#dialogue prompt here dumbo
	run_dialogue(dialogue)
	
	#controller._puzzle_check_1(solution)
	# self.queue_free()

func run_dialogue(dialogue_string):
	global.is_dialogue = true
	
	Dialogic.start(dialogue_string)
	
func dialogue_signal(arg: String):
	print("Recieved " + arg)
	await get_tree().create_timer(0.1).timeout	
	global.is_dialogue = false


func _on_body_entered(body):
	if body is Player:
		in_range = true


func _on_body_exited(body):
	if body is Player:
		in_range = false
