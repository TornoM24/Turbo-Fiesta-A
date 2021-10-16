extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var viewMode = false
var cards = []
# Called when the node enters the scene tree for the first time.
func _ready():
		
	pass
export var SWITCH_SPEED = 0.05
func switch_modes(viewMode):
	#viewMode = !viewMode
	if viewMode:
		print ("switching viewmode")
		for x in range (2,6):
			var card = get_node ("C"+str(x))
			var tween = get_node ("Tween")
			var origin = card.position
			tween.interpolate_property(card, "position",
				origin, Vector2(8, 16 + (8*(x-1))), SWITCH_SPEED,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
	if !viewMode:
		print ("switching viewmode")
		for x in range (2,6):
			var card = get_node ("C"+str(x))
			var tween = get_node ("Tween")
			var origin = card.position
			tween.interpolate_property(card, "position",
				null, Vector2(8+(208*(x-1)), 16), SWITCH_SPEED,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
	pass
func cards_show ():
	self.show()
	var cardsToShow = Master.party.size()
	var incr = 0
	for x in range (1,6):
		var cNode = get_node ("C" + str (x))
		cNode.hide()
	for ally in Master.party:
		incr += 1
		var cNode = get_node ("C" + str (incr))
		cNode.show()
		var card = cNode.get_node ("Card")
		card.get_node("HPBar").value = int((float(ally.stats.hp)/ally.stats.mhp)*100)
		card.get_node("MPBar").value = int((float(ally.stats.mp)/ally.stats.mmp)*100)
		card.get_node("Label1").bbcode_text = "[center]" + str(ally.stats.name)
		card.get_node("HPBar/HPLabel").bbcode_text = "[right]" + str(ally.stats.hp) + "/" + str(ally.stats.mhp)
		card.get_node("MPBar/MPLabel").bbcode_text = "[right]" + str(ally.stats.mp) + "/" + str(ally.stats.mmp)

	
func _process (delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
