extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var pointN = preload ("res://ui/pointer2.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(pointN)
	var tween = get_node ("Tween")
	#var origin = card.position
	tween.interpolate_property(self, "modulate",
		Color (1,1,1,0), Color (1,1,1,1), 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()                
	print ("victory screen displaying")
	render_cards()
	pass # Replace with function body.

func render_cards():
	pause_mode = PAUSE_MODE_PROCESS
	get_tree().paused = true
	var inc = 0
	for ally in Master.party:
		inc += 1
		var vCard = load("res://scenes/VictoryCard.tscn").instance()
		add_child (vCard)
		vCard.position = Vector2(160, 128 + ((inc-1) * 96))           
		vCard.name = vCard.name+str(inc)     
		vCard.get_node ("Panel/RichTextLabel").bbcode_text = ally.stats.name
		var cLevel = ally.level
		var iValue = ally.xp
		var tValue = ally.give_xp (100)
		var tLevel = ally.level
		vCard.start(cLevel, tLevel, tValue, iValue)
		#vCard.modulate.a = 0                      
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
