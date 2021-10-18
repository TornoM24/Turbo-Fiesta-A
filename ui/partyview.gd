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
func get_full (stat):
	match stat:
		"mhp" :
			return "MAX HP"
		"mmp" :
			return "MAX MP"
		"atk" :
			return "ATTACK"
		"def" : 
			return "DEFENSE"
		"int" : 
			return "INTELLIGENCE"
		"wis" :
			return "WISDOM"
		"apt" :
			return "APTITUDE"
		"spd" :
			return "SPEED"
		"luk" : 
			return "LUCK"
	
	
func switch_modes(viewMode):
	#viewMode = !viewMode
	if viewMode:
		print ("switching viewmode (detailed)")
		for x in range (2,6):
			var card = get_node ("C"+str(x))
			var tween = get_node ("Tween")
			var origin = card.position
			tween.interpolate_property(card, "position",
				origin, Vector2(8, 16 + (8*(x-1))), SWITCH_SPEED,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
		var StatsPanel = get_node ("StatsPanel")
		StatsPanel.show()
		var unit = Master.party[0]
		var stats = unit.stats
		var fullname = ""
		StatsPanel.get_node("Tabs/Stats/RichTextLabel").bbcode_text = ""
		for stat in stats.keys():
			if stat == "mhp" or stat == "mmp":
				StatsPanel.get_node("Tabs/Stats/RichTextLabel").bbcode_text += get_full(stat) + " [right]" + str(stats[stat]) + "[color=lime] ⬆" + str(unit.bonusStats[stat]) + "[/color][/right]\n"
		for stat in stats.keys():
			if !stat=="hp" and !stat=="mp" and !stat=="mhp" and !stat=="mmp" and !stat=="unitName" and !stat=="name":
				StatsPanel.get_node("Tabs/Stats/RichTextLabel").bbcode_text += get_full(stat) + " [right]" + str(stats[stat]) + "[color=lime] ⬆" + str(unit.bonusStats[stat]) + "[/color][/right]\n"
	if !viewMode:
		print ("switching viewmode (condensed)")
		for x in range (2,6):
			var card = get_node ("C"+str(x))
			var tween = get_node ("Tween")
			var origin = card.position
			tween.interpolate_property(card, "position",
				null, Vector2(8+(208*(x-1)), 16), SWITCH_SPEED,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
		var StatsPanel = get_node ("StatsPanel")
		StatsPanel.hide()
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
		card.get_node("EXPBar").value = int((float(ally.xp)/ally.toNext)*100)
		card.get_node("Label1").bbcode_text = "[center]" + ally.stats.name + " LV" + str(ally.level)
		card.get_node("HPBar/HPLabel").bbcode_text = "[right]HP " + str(ally.stats.hp) + "/" + str(ally.stats.mhp)
		card.get_node("MPBar/MPLabel").bbcode_text = "[right]MP " + str(ally.stats.mp) + "/" + str(ally.stats.mmp)
		card.get_node("EXPBar/EXPLabel").bbcode_text = "[right]EXP " + str(ally.xp) + "/" + str(ally.toNext)

	
func _process (delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
