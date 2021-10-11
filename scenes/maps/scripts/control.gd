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
		newButton.get_node ("Button").text = ability.name + " (" + str(ability.cost) + ")"
		newButton.get_node ("Button").hint_tooltip = ability.desc
		newButton.uName = ability.name
		get_node("Panel/CBPanel/specialscroll/Panel").add_child(newButton)
		print (newButton.get_parent().get_parent().get_parent().get_parent().get_parent().name)
		newButton.global_position = newButton.get_parent().rect_global_position + Vector2(20 + xOffset,20 + yOffset)
		newButton.get_node ("Button").connect ("pressed",newButton.get_parent().get_parent().get_parent().get_parent().get_parent(), "_on_ability_pressed", [newButton])
		#if xOffset == 0:
		#	xOffset = 200
		#else:
		#	xOffset = 0
		yOffset += 30
		get_node ("Panel/buttonhost/").visible=false
	
func _on_ability_pressed(bHost):
	print ("get pressed!")
	bHost.selected = false
	skillPanel.visible = false
	#tsPanel.visible = false
	bHost.visible = false
	bHost.queue_free()
	get_parent().targeting = true
	get_node ("Panel/targethelper").visible = true
			

func _on_defend_pressed():
	pass # Replace with function body.


func _on_item_pressed():
	pass # Replace with function body.


func _on_attack_pressed():
	tsPanel.visible = !tsPanel.visible
	get_parent().targeting = true
	get_parent().get_node ("Control/Panel/targethelper").visible = true
	get_parent().get_node ("Control/Panel/buttonhost").visible = false
	pass # Replace with function body.
