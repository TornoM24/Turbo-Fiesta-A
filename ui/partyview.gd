extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var viewMode = false
var cards = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range (1,6):
		var card = load ("res://ui/card.tscn").instance()
		add_child (card)
		card.position = Vector2 (8 + (208 * x-1), -64)
		card.name = "C" + str (x)
		card.z_index = 998
	pass
export var SWITCH_SPEED = 0.5
	
var number = 1
var maxNumber
var equipsDrawn = []

func sort_equip (eitem):
	if eitem.location == "inventory":
		Master.party [number-1].equip (eitem.item)
		var k = Master.inventory.find (eitem.item)
		eitem.hide()
		print (Master.inventory[k].itemName)
		Master.inventory.remove (k)
	else:
		Master.party [number-1].unequip (eitem.item)
		var k = Master.party [number-1].equipment.find (eitem.item)
		Master.inventory.append (eitem.item)
		Master.party [number-1].equipment.remove (k)
		eitem.hide()
	draw_equip (Master.party[number-1])
	update_stats()

func draw_equip (unit):
	var CEPanel = get_node ("StatsPanel/Tabs/Equipment/ScrollContainer/Control")
	get_node ("StatsPanel/Tabs/Equipment/costlabel").bbcode_text = "[right]Cost : ★" + str (unit.cost) + "/" + str (unit.maxCost)
	for x in get_node ("StatsPanel/Tabs/Equipment/ScrollContainer2/Control").get_children():
		print ("attempting to hide "+x.item.itemName)
		x.hide()
	for x in get_node ("StatsPanel/Tabs/Equipment/ScrollContainer/Control").get_children():
		print ("attempting to hide "+x.item.itemName)
		x.hide()
	var equipment_prefab = load ("res://ui/equipment_element.tscn")
	var fnX = 0
	var incr = 0
	for x in unit.equipment:
		incr += 1
	if incr <= 0:
		get_node ("StatsPanel/Tabs/Equipment/Panel2/RichTextLabel").show()
	else:
		get_node ("StatsPanel/Tabs/Equipment/Panel2/RichTextLabel").hide()
	incr = 0
	for x in Master.inventory:
		incr += 1
	if incr <= 0:
		get_node ("StatsPanel/Tabs/Equipment/Panel/RichTextLabel").show()
	else:
		get_node ("StatsPanel/Tabs/Equipment/Panel/RichTextLabel").hide()
	for x in unit.equipment:
		var equipment_item = equipment_prefab.instance()
		CEPanel.add_child (equipment_item)
		equipment_item.position = CEPanel.rect_position + Vector2 (20 + (fnX*88),20)
		equipment_item.init (x)
		equipment_item.location = "equipment"
		print ("drew equipment slot at position "+str(equipment_item.position))
		fnX += 1
	var IPanel = get_node ("StatsPanel/Tabs/Equipment/ScrollContainer2/Control")
	fnX = 0
	for x in Master.inventory:
		var inv_item = equipment_prefab.instance()
		IPanel.add_child (inv_item)
		inv_item.position += Vector2 (20 + (fnX*88),20)
		inv_item.init (x)
		inv_item.location = "inventory"
		print ("drew inventory slot at position "+str(inv_item.position))
		fnX += 1
	pass
func _input(ev):
	if ev is InputEventKey and ev.is_action_pressed ("cheat") and not ev.is_echo():
		Master.party[0].equip (Master.give_equipment("hiro_heirloom"))
	
func gp_len ():
	var maxn = 0
	for x in Master.party:
		maxn += 1
	return maxn

func update_stats ():
	var StatsPanel = get_node ("StatsPanel")
	var unit = Master.party[number-1]
	var stats = unit.stats
	var fullname = ""
	StatsPanel.get_node("Stats/RichTextLabel").bbcode_text = ""
	var inc = 1
	for stat in stats.keys():
		if stat == "mhp" or stat == "mmp":
			var newCard = load ("res://ui/statcard.tscn").instance()
			StatsPanel.get_node ("Stats").add_child (newCard)
			newCard.get_node ("Title").bbcode_text = ""+Master.get_full (stat)
			newCard.get_node ("Total").bbcode_text = "[right][color=yellow]" + str(stats[stat]) + "[/color][color=lime] + " + str(unit.bonusStats[stat]) + ""
			newCard.get_node ("RichTextLabel").bbcode_text = "[right]" + str(stats[stat] + unit.bonusStats[stat]) + ""
			newCard.position.y = (inc * 58)
			StatsPanel.get_node("Stats/RichTextLabel").bbcode_text += Master.get_full(stat) + " [right]" + str(stats[stat]) + "[color=lime] +" + str(unit.bonusStats[stat]) + "[/color][/right]\n"
			inc += 1
	for stat in stats.keys():
		if !stat=="hp" and !stat=="mp" and !stat=="mhp" and !stat=="mmp" and !stat=="unitName" and !stat=="name":
			var newCard = load ("res://ui/statcard.tscn").instance()
			StatsPanel.get_node ("Stats").add_child (newCard)
			newCard.get_node ("Title").bbcode_text = ""+Master.get_full (stat)
			newCard.get_node ("Total").bbcode_text = "[right][color=yellow]" + str(stats[stat]) + "[/color][color=lime] + " + str(unit.bonusStats[stat]) + ""
			newCard.get_node ("RichTextLabel").bbcode_text = "[right]" + str(stats[stat] + unit.bonusStats[stat]) + ""
			StatsPanel.get_node("Stats/RichTextLabel").bbcode_text += Master.get_full(stat) + " [right]" + str(stats[stat]) + "[color=lime] +" + str(unit.bonusStats[stat]) + "[/color][/right]\n"
			newCard.position.y = (inc * 58)
			inc += 1
	var incr = 0
	unit.maxCost = unit.stats.apt
	for ally in Master.party:
		incr += 1
		var cNode = get_node ("C" + str (incr))
		var card = cNode.get_node ("Card")
		card.get_node("HPBar").value = int((float(ally.stats.hp)/ally.stats.mhp)*100)
		card.get_node("MPBar").value = int((float(ally.stats.mp)/ally.stats.mmp)*100)
		card.get_node("EXPBar").value = int((float(ally.xp)/ally.toNext)*100)
		card.get_node("Label1").bbcode_text = "[center]" + ally.stats.name + " LV" + str(ally.level)
		card.get_node("HPBar/HPLabel").bbcode_text = "[right]HP " + str(ally.stats.hp) + "/" + str(ally.stats.mhp)
		card.get_node("MPBar/MPLabel").bbcode_text = "[right]MP " + str(ally.stats.mp) + "/" + str(ally.stats.mmp)
		card.get_node("EXPBar/EXPLabel").bbcode_text = "[right]EXP " + str(ally.xp) + "/" + str(ally.toNext)

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
		update_stats()
		draw_equip(Master.party[number-1])
		
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
	get_node ("Spreader").open()
	get_node ("Spreader2").open()
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
func draw_abilities (unit):
	var abilityControl = get_node ("StatsPanel/Tabs/Abilities/ScrollContainer/Control")
	var yOffset = 0
	for x in unit.abilities:
		var aCard = load ("res://ui/ability_card.tscn").instance()
		aCard.init (x)
		abilityControl.add_child(aCard)
		aCard.position.y = yOffset
		yOffset += 120
	abilityControl.rect_min_size.y = yOffset
func update_sp (value):
	if value != Master.party[number-1].sp:
		get_node ("StatsPanel/Tabs/Growth/TabContainer/Stat Points/Panel2/RichTextLabel").bbcode_text = "Remaining SP : [color=yellow]" + str (value)
	else:
		get_node ("StatsPanel/Tabs/Growth/TabContainer/Stat Points/Panel2/RichTextLabel").bbcode_text = "Remaining SP : " + str (value)
func draw_parameters (unit):
	var statPan = get_node ("StatsPanel/Tabs/Growth/TabContainer/Stat Points/Panel")
	var stats = unit.stats
	var yOffset = 24
	update_sp (unit.sp)
	unit.spendable = unit.sp
	for stat in stats.keys():
		if stat == "mhp" or stat == "mmp":
			var statBox = load ("res://ui/StatContainer.tscn").instance()
			statBox.init (stat, unit.stats[stat])
			statPan.add_child(statBox)
			statBox.position = Vector2 (24, yOffset)
			statBox.parent = self
			statBox.unit = unit
			yOffset += 32
	for stat in stats.keys():
		if !stat=="hp" and !stat=="mp" and !stat=="mhp" and !stat=="mmp" and !stat=="unitName" and !stat=="name":
			var statBox = load ("res://ui/StatContainer.tscn").instance()
			statBox.init (stat, unit.stats[stat])
			statPan.add_child(statBox)
			statBox.position = Vector2 (24, yOffset)
			statBox.parent = self
			statBox.unit = unit
			yOffset += 32
func _on_Tabs_tab_selected(tab):
	if tab == 0:
		for x in get_node ("StatsPanel/Tabs/Equipment/ScrollContainer/Control").get_children():
			if x!=null:
				x.hide()
		print ("on equips screen")
		draw_equip (Master.party[number-1])
	if tab == 1:
		for x in get_node ("StatsPanel/Tabs/Abilities/ScrollContainer/Control").get_children():
			if x!=null:
				x.hide()
		print ("on abilities screen")
		draw_abilities (Master.party[number-1])
	if tab == 3:
		var bStat = get_node ("StatsPanel/Tabs/Growth/TabContainer")
		if bStat.current_tab == 0:
			for x in bStat.get_node ("Stat Points/Panel").get_children():
				if x!=null:
					x.hide()
			print ("on abilities screen")
			draw_parameters (Master.party[number-1])
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
	Master.party[number-1].equip (item)
	pass


func _on_Confirm_pressed():
	for x in get_node ("StatsPanel/Tabs/Growth/TabContainer/Stat Points/Panel").get_children():
		var tt = x.stat
		var unit = Master.party[number-1]
		var increase = x.target - unit.stats[tt]
		unit.stats[tt] = x.target
		unit.sp = unit.spendable
		update_sp (unit.sp)
		x.val = unit.stats[tt]
		if tt == "mhp":
			print ("healing by " + str (int (float(increase)/3)))
			unit.stats.hp += int (float(increase)/3)
		if tt == "mmp":
			unit.stats.hp += int (float(increase)/3)
		x.check()
		update_stats()
	pass # Replace with function body.


func _on_Reset_pressed():
	for x in get_node ("StatsPanel/Tabs/Growth/TabContainer/Stat Points/Panel").get_children():
		var tt = x.stat
		var unit = Master.party[number-1]
		x.val = unit.stats[tt]
		x.target = x.val
		unit.spendable = unit.sp
		x.check()
		update_sp(unit.sp)
		update_stats()
	pass # Replace with function body.
