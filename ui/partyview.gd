extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var viewMode = false
var cards = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range (1,6):
		var card = get_node ("C"+str(x))
		card.z_index = 998
	pass
export var SWITCH_SPEED = 0.5
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
	
var number = 1
var maxNumber
var equipsDrawn = []
func draw_equip (unit):
	var CEPanel = get_node ("StatsPanel/Tabs/Equipment/ScrollContainer/Panel")
	var equipment_prefab = load ("res://ui/equipment_element.tscn")
	var fnX = 0
	for x in unit.equipment:
		print (x.itemName)
	for x in unit.equipment:
		var equipment_item = equipment_prefab.instance()
		CEPanel.add_child (equipment_item)
		#print (x)
		equipment_item.get_node("Panel/Sprite").texture = load ("res://gfx/equip/"+x.id+ ".png")
		equipment_item.get_node("Panel/RichTextLabel").bbcode_text = x.itemName
		equipment_item.position = CEPanel.rect_position + Vector2 (20 + (fnX*88),20)
		print ("drew equipment slot at position "+str(equipment_item.position))
		#equipsDrawn.append (equipment_item)
		fnX += 1
	var equipment_item = equipment_prefab.instance()
	CEPanel.add_child (equipment_item)
	equipment_item.position = CEPanel.rect_position + Vector2 (20 + (fnX*88),20)
	var IPanel = get_node ("StatsPanel/Tabs/Equipment/Panel")
	
	fnX = 0
	for x in Master.inventory:
		var inv_item = equipment_prefab.instance()
		IPanel.add_child (inv_item)
		print (x)
		inv_item.get_node("Panel/Sprite").texture = load ("res://gfx/equip/"+x.id+ ".png")
		inv_item.get_node("Panel/RichTextLabel").bbcode_text = x.itemName
		inv_item.position += Vector2 (20 + (fnX*88),20)
		print ("drew inventory slot at position "+str(inv_item.position))
		fnX += 1
		#equipsDrawn.append (equipment_item)
	pass
func _input(ev):
	if ev is InputEventKey and ev.is_action_pressed ("cheat") and not ev.is_echo():
		Master.party[0].equip (Master.give_equipment("hiro_heirloom"))
	
func gp_len ():
	var maxn = 0
	for x in Master.party:
		maxn += 1
	return maxn
func switch_modes(viewMode):
	#viewMode = !viewMode
	if viewMode:
		print ("switching viewmode (detailed)")
		var topCard = get_node ("C"+str(number))
		var torigin = topCard.position
		var tween = get_node ("Tween")
		topCard.z_index = 999
		tween.interpolate_property(topCard, "position",
			torigin, Vector2(8, -40), SWITCH_SPEED,
		Tween.TRANS_QUART, Tween.EASE_OUT)
		tween.start()
		var nonTops = []
		for x in range (1,6):
			var card = get_node ("C"+str(x))
			if card != topCard:
				nonTops.append (card)
				print ("appended " + card.name)
		for y in range (0,4):
			var card = nonTops [y]
			card.z_index = 998
			var origin = card.position
			tween.interpolate_property(card, "position",
				origin, Vector2(8, -40 + (8*(y+1))), SWITCH_SPEED,
			Tween.TRANS_QUART, Tween.EASE_OUT)
			tween.start()
		var StatsPanel = get_node ("StatsPanel")
		StatsPanel.show()
		tween.interpolate_property(StatsPanel, "modulate",
			Color (1,1,1,0), Color (1,1,1,1), 0.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
		tween.start()
		var unit = Master.party[number-1]
		var stats = unit.stats
		var fullname = ""
		StatsPanel.get_node("Stats/RichTextLabel").bbcode_text = ""
		for stat in stats.keys():
			if stat == "mhp" or stat == "mmp":
				StatsPanel.get_node("Stats/RichTextLabel").bbcode_text += get_full(stat) + " [right]" + str(stats[stat]) + "[color=lime] ⬆" + str(unit.bonusStats[stat]) + "[/color][/right]\n"
		for stat in stats.keys():
			if !stat=="hp" and !stat=="mp" and !stat=="mhp" and !stat=="mmp" and !stat=="unitName" and !stat=="name":
				StatsPanel.get_node("Stats/RichTextLabel").bbcode_text += get_full(stat) + " [right]" + str(stats[stat]) + "[color=lime] ⬆" + str(unit.bonusStats[stat]) + "[/color][/right]\n"
		
	if !viewMode:
		print ("switching viewmode (condensed)")
		for x in range (1,6):
			var card = get_node ("C"+str(x))
			var tween = get_node ("Tween")
			var origin = card.position
			tween.interpolate_property(card, "position",
				null, Vector2(8+(208*(x-1)), -40), SWITCH_SPEED,
			Tween.TRANS_QUART, Tween.EASE_OUT)
			tween.start()
		var StatsPanel = get_node ("StatsPanel")
		var tween = get_node ("Tween")
		tween.interpolate_property(StatsPanel, "modulate",
			Color (1,1,1,1), Color (1,1,1,0), 0.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
		tween.start()
	pass
func cards_show ():
	self.show()
	var tween = get_node ("Tween")
	tween.interpolate_property(self, "modulate",
		Color (1,1,1,0), Color (1,1,1,1), 0.5,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
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
		var idlePath = load("res://data/unit/"+ally.unitName+"/art/"+ally.unitName+"_idle.tres")
		cNode.get_node("Card/CharSprite").frames = idlePath
		card.get_node("HPBar").value = int((float(ally.stats.hp)/ally.stats.mhp)*100)
		card.get_node("MPBar").value = int((float(ally.stats.mp)/ally.stats.mmp)*100)
		card.get_node("EXPBar").value = int((float(ally.xp)/ally.toNext)*100)
		card.get_node("Label1").bbcode_text = "[center]" + ally.stats.name + " LV" + str(ally.level)
		card.get_node("HPBar/HPLabel").bbcode_text = "[right]HP " + str(ally.stats.hp) + "/" + str(ally.stats.mhp)
		card.get_node("MPBar/MPLabel").bbcode_text = "[right]MP " + str(ally.stats.mp) + "/" + str(ally.stats.mmp)
		card.get_node("EXPBar/EXPLabel").bbcode_text = "[right]EXP " + str(ally.xp) + "/" + str(ally.toNext)

func _button_pressed (button):
	get_node ("StatsPanel/Tabs").current_tab = 1
	get_node ("StatsPanel/Tabs").current_tab = 0
	number = int(button.get_parent().name.substr(1,-1))
	print (button.get_parent().name)
	switch_modes(true)
	
func _process (delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tabs_tab_selected(tab):
	if tab == 0:
		for x in get_node ("StatsPanel/Tabs/Equipment/ScrollContainer/Panel").get_children():
			if x!=null:
				x.hide()
		print ("on equips screen")
		draw_equip (Master.party[number-1])
	pass # Replace with function body.


func _on_right_pressed():
	number += 1
	if number > gp_len():
		number = 1
	var ot = get_node ("StatsPanel/Tabs").current_tab
	get_node ("StatsPanel/Tabs").current_tab = 0
	get_node ("StatsPanel/Tabs").current_tab = ot
	switch_modes (true)
	pass # Replace with function body.


func _on_left_pressed():
	number -= 1
	if number < 1:
		number = gp_len()
	var ot = get_node ("StatsPanel/Tabs").current_tab
	get_node ("StatsPanel/Tabs").current_tab = 0
	get_node ("StatsPanel/Tabs").current_tab = ot
	switch_modes (true)
	pass # Replace with function body.

func _on_item_pressed (item):
	Master.party[number].equip (item)
	pass
