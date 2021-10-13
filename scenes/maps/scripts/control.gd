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
	var skillPanel = get_node("Panel/CBPanel")
	var tsPanel = get_node("Panel/Panel2")
	for x in get_node ("Panel/CBPanel/specialscroll/Panel").get_children():
		x.queue_free()
	skillPanel.visible = false
	tsPanel.visible = false
	get_node ("Panel/buttonhost/").visible=true
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
			tipText += "EFFECT "+ str (inc)+ ": Deals " + str(x.power) + "% of character's " + scalers + " as " + elements + " damage."
	return tipText
		
func _on_special_pressed():
	skillPanel.visible = !skillPanel.visible
	tsPanel.visible = !tsPanel.visible
	get_node ("Panel/CBPanel/specialscroll").scroll_vertical = 0
	var unitGet = get_parent().selectedUnit
	var yOffset = 0
	var xOffset = 0
	for ability in unitGet.get_node ("Data").unitDict["abilities"]:
		var newButton = abilityButton.instance()
		#print (ability.name)
		newButton.get_node ("Button").text = ability.name
		newButton.get_node ("Button").hint_tooltip = ability.desc + "\n\n" + generateTip (ability)
		newButton.uName = ability.name
		newButton.aName = ability.id
		get_node("Panel/CBPanel/specialscroll/Panel").add_child(newButton)
		print (newButton.get_parent().get_parent().get_parent().get_parent().get_parent().name)
		newButton.global_position = newButton.get_parent().rect_global_position + Vector2(20 + xOffset,20 + yOffset)
		newButton.get_node ("Button").connect ("pressed",newButton.get_parent().get_parent().get_parent().get_parent().get_parent(), "_on_ability_pressed", [newButton])
		newButton.get_node ("MPLabel").bbcode_text = "MP [color=#00c8ff]" + str(ability.cost) + "[/color]"
		#if xOffset == 0:
		#	xOffset = 200
		#else:
		#	xOffset = 0
		yOffset += 70
		get_node ("Panel/buttonhost/").visible=false
	
func _on_ability_pressed(bHost):
	print ("get pressed!")
	var selector = get_parent().get_node("Control/Selector")
	var flag = false
	for x in Master.ability_dict[bHost.aName].effects:
		if x.target == "all allies":
			var par = get_parent()
			get_parent().causeEffect (par.selectedTarget,0,Master.ability_dict[bHost.aName].effects)
			get_parent().cancelTargeting()
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
			

func _on_defend_pressed():
	pass # Replace with function body.


func _on_item_pressed():
	pass # Replace with function body.


func _on_attack_pressed():
	tsPanel.visible = !tsPanel.visible
	get_parent().targeting = true
	get_parent().get_node ("Control/Panel/targethelper").visible = true
	get_parent().get_node ("Control/Panel/buttonhost").visible = false
	get_parent().targetAbility = Master.ability_dict["attack_basic_attack"]
	pass # Replace with function body.
