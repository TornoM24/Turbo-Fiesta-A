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
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init (unit):
	parent = get_tree().get_root().get_node ("Controller")
	get_node ("Panel/namedisplay/RichTextLabel").bbcode_text = "[center]" + unit.stats.name
	get_node ("Panel/buttonhost/attack").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_attack_pressed", [self])
	get_node ("Panel/buttonhost/defend").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_defend_pressed", [self])
	get_node ("Panel/buttonhost/item").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_item_pressed", [self])
	get_node ("Panel/buttonhost/special").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_special_pressed", [self])
	assignment = unit
	#parent.selectedUnit = assignment
	active = true
	origin = position
	pass

func _process(delta):
	get_node ("Panel/namedisplay/ATBBar").value = assignment.atb_val
	if active:
		#print (assignment.stats.name + " " + str(assignment.atb_val))
		if assignment.atb_val >= 100:
			inReady = true
			if position.y >= 0:
				shift_up()
		else: 
			inReady = false
			if position.y <= -256:
				print (position.y)
				shift_down()
	pass

func shift_up():
	var tween = get_node ("Tween")
	tween.interpolate_property(self, "position",
		null, Vector2(position.x, position.y-256), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	
func shift_down():
	var tween = get_node ("Tween")
	tween.interpolate_property(self, "position",
		null, Vector2(position.x, position.y+256), 0.2,
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
		parent.selectedUnit = assignment
		parent.hide_all()
	pass # Replace with function body.


func _on_Tween_tween_all_completed():
	pass # Replace with function body.


func _on_act_pressed():
	
	if inReady:
		get_parent().currentPan = ind
		get_parent().update_panels(get_parent().abilityPanels)
		get_parent().abilityPanels [get_parent().currentPan].get_node ("Panel/buttonhost/act").show_buttons()

	pass # Replace with function body.
