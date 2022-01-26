extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var progress = 0
var phase = 1
onready var text = get_node ("RichTextLabel1")
onready var tween = get_node ("Tween")
# Called when the node enters the scene tree for the first time.
func _ready():
	text.visible_characters = 0
	pass # Replace with function body.

func next_phase ():
	phase += 1
	if phase <= 2:
		get_node ("RichTextLabel"+str(phase-1)).hide()
		var lb = get_node ("RichTextLabel"+str(phase))
		lb.show()
		lb.visible_characters = 0
		text = lb
	else:
		get_node("/root/Global").goto_scene("res://scenes/maps/hub.tscn")

func _input(ev):
	if ev.is_action_pressed ("click") or ev.is_action_pressed ("interact"):
		if text.visible_characters >= text.get_total_character_count():
			next_phase()
		else:
			text.visible_characters = text.get_total_character_count()
func _process (delta):
	progress += delta
	if progress >= 0.01:
		text.visible_characters += 1
		progress = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
