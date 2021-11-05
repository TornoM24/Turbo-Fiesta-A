extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var yOffset = 0
var sceneBase
var freePath
# Called when the node enters the scene tree for the first time.
func _ready():
	print ("it is done")
	var tween = get_node ("Tween")
	#var origin = card.position
	tween.interpolate_property(self, "modulate",
		Color (1,1,1,0), Color (1,1,1,1), 0.2,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pause_mode = Node.PAUSE_MODE_PROCESS
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate_status (pUnit):
	var stats = pUnit.stats
	var inc = 0
	get_node ("Panel/UnitName").bbcode_text = pUnit.stats.name
	for stat in stats.keys():
		if stat != "hp" and stat != "mp" and stat != "name":
			if stat == "mhp" or stat == "mmp":
				var newCard = load ("res://ui/statcard.tscn").instance()
				get_node ("Panel/ScrollContainer/Control/Panel").add_child (newCard)
				newCard.position = Vector2(10,20 + inc * 36)
				inc += 1
				newCard.init (stat, pUnit.reference)
				newCard.show()
	for stat in stats.keys():
		if stat != "hp" and stat != "mp" and stat != "name":
			if stat != "mhp" and stat != "mmp":
				var newCard = load ("res://ui/statcard.tscn").instance()
				newCard.z_index += inc*2
				get_node ("Panel/ScrollContainer/Control/Panel").add_child (newCard)
				newCard.position = Vector2(10,20 + inc * 36)
				inc += 1
				newCard.init (stat, pUnit.reference)
				newCard.show()
	inc = 0
	for effect in pUnit.tempEffects:
		print (effect)
		var x = get_node ("Panel/ScrollContainer/Control/BuffPanel")
		var eff = load ("res://ui/status_effect.tscn").instance()
		eff.init(effect)
		eff.source = effect.source
		x.add_child (eff)
		eff.position += Vector2(10 + 30 * inc,20)
		inc+=1 
	pass

func _on_Button_pressed():
	if sceneBase == "combat":
		get_tree().paused = false
	else:
		get_node (freePath).pause_mode = PAUSE_MODE_PROCESS
	queue_free()
	pass # Replace with function body.
