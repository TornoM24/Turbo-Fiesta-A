extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var assignment
var parent
var active = false
var origin
var inReady = false
var ind = -1

onready var atb = get_node ("ATB2")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var shake = get_node ("shakenode")
onready var hpbar = get_node ("namedisplay/HPBar")
func shake():
	shake.start(hpbar, 0.2, 50, 4)

func init (unit):
	parent = get_tree().get_root().get_node ("Controller")
	get_node ("namedisplay/RichTextLabel").bbcode_text = "[center]" + unit.stats.name
	get_node ("namedisplay/Status").text = unit.stats.name
	get_node ("Panel/buttonhost/attack").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_attack_pressed", [self])
	get_node ("Panel/buttonhost/defend").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_defend_pressed", [self])
	get_node ("Panel/buttonhost/item").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_item_pressed", [self])
	get_node ("Panel/buttonhost/special").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_special_pressed", [self])
	get_node ("namedisplay/HPBar").value = unit.stats.hp
	assignment = unit
	#parent.selectedUnit = assignment
	active = true
	origin = position
	pass

onready var panel = get_node ("Panel")
const ORIENTATION = ""
var targetPosition = Vector2(704,376)
var offset = 208
func _process(delta):
	get_node ("namedisplay/ATBBar").value = assignment.atb_val
	get_node ("ATB2").value = assignment.atb_val
	get_node("namedisplay/HPLabel").bbcode_text = ORIENTATION + str (assignment.stats.hp) + "/" + str (assignment.stats.mhp)
	get_node("namedisplay/MPLabel").bbcode_text = ORIENTATION + str (assignment.stats.mp) + "/" + str (assignment.stats.mmp)
	if active:
		#print (assignment.stats.name + " " + str(assignment.atb_val))
		if assignment.atb_val >= 100:
			inReady = true
			if panel.rect_position.y >= targetPosition.x:
				shift_up()
		else: 
			inReady = false
			if panel.rect_position.y <= targetPosition.y:
				print (position.y)
				shift_down()
	pass
onready var cir = get_node ("Panel/circle")
func shift_up():
	var tween = get_node ("Tween")
	tween.interpolate_property(panel, "rect_position",
	#tween.interpolate_property(self, "position",
		#null, Vector2(position.x, position.y-256), 0.2,
		panel.rect_position, Vector2(panel.rect_position.x, panel.rect_position.y-offset), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	
func shift_down():
	get_node ("Panel/buttonhost/acter/act").hide_buttons()
	var tween = get_node ("Tween")
	tween.interpolate_property(panel, "rect_position",
	#tween.interpolate_property(self, "position",
		#null, Vector2(position.x, position.y+256), 0.2,
		panel.rect_position, Vector2(panel.rect_position.x, panel.rect_position.y+offset), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_attack_pressed():
	if inReady:
		parent.selectedUnit = assignment
		parent.hide_all()
	pass

func _on_defend_pressed():
	if inReady:
		parent.selectedUnit = assignment
	pass # Replace with function body.

func _on_special_pressed():
	if inReady:
		Master.abiOpen = true
		parent.selectedUnit = assignment
		parent.hide_all()
	pass # Replace with function body.


func _on_Tween_tween_all_completed():
	pass # Replace with function body.


func _on_act_pressed():
	
	if inReady:
		get_parent().currentPan = ind
		get_parent().update_panels(get_parent().abilityPanels)
		get_parent().abilityPanels [get_parent().currentPan].get_node ("Panel/buttonhost/acter/act").show_buttons()

	pass # Replace with function body.
