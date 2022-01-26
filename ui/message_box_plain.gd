extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#-160, -32
#-94, -24
#-88, -8
var timerProg = 0
var timerLimit = 0
var cVis = 0
var targetText = ""
var dReady = false
# Called when the node enters the scene tree for the first time.
func _ready():
	dReady = false
	rng.randomize()
	var tween = get_node ("Tween")
	get_node ("Label").hide()
	get_node ("Text").hide()
	get_node ("Label").rect_position = get_node ("Panel").rect_position + Vector2 (66, 8)
	get_node ("Text").rect_position = get_node ("Panel").rect_position + Vector2 (72, 24)
	tween.interpolate_property(get_node ("Panel"), "rect_size",
		Vector2 (0,64), Vector2 (320,64), 0.25,
		Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	tween.start()
	pass # Replace with function body.

#func _process (delta):
#	get_node ("Panel").rect_position = Vector2(0,0)

func typewrite (title, text, speed):
	get_node ("Label").bbcode_text = title
	get_node ("Text").bbcode_text = text
	get_node ("Text").visible_characters = 0
	get_node ("Next").hide()
	timerLimit = speed
	cVis = 0
	#get_node ("Label"). ()
var rng = RandomNumberGenerator.new()
func _process (delta):
	if get_node ("Text").get_total_character_count () > get_node ("Text").visible_characters:
		timerProg += delta
		if timerProg >= timerLimit:
			timerProg = 0
			get_node ("Text").visible_characters += 1
			AudioManager.play (AudioManager.Type.NON_POSITIONAL, self, load("res://sfx/sounds/click.wav"),-30.0,0.7)
			if get_node ("Text").get_total_character_count () == get_node ("Text").visible_characters:
				get_node ("Next").show()

func _input (ev):
	if ev is InputEventKey and ev.is_action_pressed("interact") and not ev.is_echo():
		if dReady:
			if get_node ("Text").get_total_character_count () > get_node ("Text").visible_characters:
				get_node ("Text").visible_characters = get_node ("Text").get_total_character_count ()  
				get_node ("Next").show()
			else:
				queue_free()
				DialogManager.next_dialog()

func _on_Tween_tween_all_completed():
	get_node ("Label").show()
	get_node ("Text").show()
	dReady = true
	pass # Replace with function body.

func _on_Button_pressed():
	if dReady:
		if get_node ("Text").get_total_character_count () > get_node ("Text").visible_characters:
			get_node ("Text").visible_characters = get_node ("Text").get_total_character_count ()  
			get_node ("Next").show()
		else:
			DialogManager.next_dialog()	
			queue_free()
	pass # Replace with function body.
