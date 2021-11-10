extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 500

onready var skillPanel = get_node("Panel/CBPanel")
onready var tsPanel = get_node("Panel/Panel2")

onready var attackButton = get_node("Panel/buttonhost/attack")
onready var defendButton = get_node("Panel/buttonhost/defend")
onready var specialButton = get_node("Panel/buttonhost/special")
onready var itemButton = get_node("Panel/buttonhost/item")
var abilityButton = preload ("res://data/abilities/ability_button.tscn")

var isSelecting = false

var sPanelX = 0
var sPanelY = 212

var gTimer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_exit_pressed():
	get_parent ().abilityPanels [get_parent().currentPan].get_node ("Panel/buttonhost/acter/act").show_buttons()
	var skillPanel = get_node("Panel/CBPanel")
	var tsPanel = get_node("Panel/Panel2")
	for x in get_node ("Panel/CBPanel/specialscroll/Panel").get_children():
		x.queue_free()
	skillPanel.a_hide()
	tsPanel.visible = false
	get_node ("Panel/buttonhost/").visible=true
	get_parent().show_all()
	pass # Replace with function body.
func generateTip (ability):
	var tipText = ""
	var inc = 0
	for x in ability.effects:
		inc +=1
		if x.type == "damage":
			var scalers = ""
			var elements = ""
			var xinc = 0
			for y in x.scaling:
				xinc += 1
				if xinc>1:
					scalers += "/"+ y 
				else:
					scalers += y
			xinc = 0
			for z in x.elements:
				xinc += 1
				if xinc>1:
					elements += "/"+ z
				else:
					elements += z
			scalers=scalers.to_upper()
			elements=elements.to_upper()
			if x.target == "single":
				tipText += "EFFECT "+ str (inc)+ ": Deals " + str(x.power) + "% of character's " + scalers + " as " + elements + " damage."
			elif x.target == "self":
				tipText += "EFFECT "+ str (inc)+ ": Deals " + str(x.power) + " " + elements + " damage to self."
		tipText+= "\n\n"
	return tipText
		
func _on_special_pressed(button):
	skillPanel.a_show()
	tsPanel.visible = !tsPanel.visible
	get_node ("Panel/CBPanel/specialscroll").scroll_vertical = 0
	get_node("Panel/CBPanel/specialscroll/Panel").rect_min_size.y = 0
	get_parent().selectedUnit = button.assignment
	var unitGet = get_parent().selectedUnit
	var yOffset = 0
	var xOffset = 0
	print ("creating abilities for " + unitGet.reference.unitName)
	for ability in unitGet.reference.abilities:
		var newButton = abilityButton.instance()
		#print (ability.name)
		newButton.get_node ("Button").text = ability.name
		#newButton.get_node ("Button").hint_tooltip = ability.desc + "\n\n" + generateTip (ability)
		newButton.uName = ability.name
		newButton.aName = ability.id
		get_node("Panel/CBPanel/specialscroll/Panel").add_child(newButton)
		#print (newButton.get_parent().get_parent().get_parent().get_parent().get_parent().name)
		#print (newButton.get_tree().get_root().get_node("Controller/Control").name)
		newButton.global_position = newButton.get_parent().rect_global_position + Vector2(20 + xOffset,20 + yOffset)
		#newButton.get_node ("Button").connect ("pressed",newButton.get_tree().get_root().get_node("Controller/Control"), "_on_ability_pressed", [newButton])
		newButton.get_node ("MPLabel").bbcode_text = "MP [color=#00c8ff]" + str(ability.cost) + "[/color]"
		#if xOffset == 0:
		#	xOffset = 200
		#else:
		#	xOffset = 0
		newButton.get_node ("Button").icon=load("res://gfx/icons/"+ability.icon+".png")
		if ability.cost > unitGet.reference.stats.mp:
			newButton.disable_button()
		yOffset += 85
		get_node("Panel/CBPanel/specialscroll/Panel").rect_min_size.y = yOffset
		get_node ("Panel/buttonhost/").visible=false
	
func ability_pressed(bHost, inputType):
	#print (inputType)
	if inputType == 1:
		#print ("get pressed!")
		var selector = get_parent().get_node("Control/Selector")
		var flag = false
		for x in Master.ability_dict[bHost.aName].effects:
			if x.target == "all allies" or x.target == "all enemies":
				var par = get_parent()
				get_parent().selectedUnit.sprite_attack(Master.ability_dict[bHost.aName],par.selectedUnit)
				get_parent().cancel_targeting()
				par.skillPanel.visible = false
				par.selectedUnit.atb_val = 0
				par.isSelecting = false
				selector.visible = false
			else:
				bHost.selected = false
				skillPanel.visible = false
				#tsPanel.visible = false
				bHost.visible = false
				get_parent().targeting = true
				get_parent().targetAbility = Master.ability_dict[bHost.aName]
				get_node ("Panel/targethelper").visible = true
		bHost.queue_free()
	elif inputType == 2:
		var x = load("res://ui/ability_hint.tscn").instance()
		x.sceneBase = "combat"
		x.generateTip (Master.ability_dict[bHost.aName])
		get_parent().add_child(x)
		get_tree().paused = true

func _on_defend_pressed(host):
	if host.inReady:
		pass # Replace with function body.


func _on_item_pressed(host):
	if host.inReady:
		pass # Replace with function body.


func _on_attack_pressed(host):
	#if get_parent().selectedUnit.atb_val >= 100:
	if host.inReady:
		tsPanel.visible = !tsPanel.visible
		get_parent().targeting = true
		get_parent().get_node ("Control/Panel/targethelper").visible = true
		get_parent().get_node ("Control/Panel/buttonhost").visible = false
		get_parent().targetAbility = Master.ability_dict["attack_basic_attack"]
	pass # Replace with function body.
