extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var assignment
var parent
var active = false
var origin
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init (unit):
	parent = get_tree().get_root().get_node ("Controller")
	get_node ("Panel/namedisplay/RichTextLabel").bbcode_text = "[center]" + unit.stats.name
	get_node ("Panel/buttonhost/attack").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_attack_pressed")
	get_node ("Panel/buttonhost/defend").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_defend_pressed")
	get_node ("Panel/buttonhost/item").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_item_pressed")
	get_node ("Panel/buttonhost/special").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_special_pressed", [self])
	assignment = unit
	#parent.selectedUnit = assignment
	active = true
	origin = position
	pass

func _process(delta):
	if active:
		#print (assignment.stats.name + " " + str(assignment.atb_val))
		if assignment.atb_val >= 100:
			if position.y >= 0:
				shift_up()
		else: 
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
	parent.selectedUnit = assignment
	parent.hide_all()
	pass

func _on_defend_pressed():
	parent.selectedUnit = assignment
	pass # Replace with function body.

func _on_special_pressed():
	parent.selectedUnit = assignment
	parent.hide_all()
	pass # Replace with function body.


func _on_Tween_tween_all_completed():
	pass # Replace with function body.
