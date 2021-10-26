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
	get_node ("Panel/buttonhost/special").connect ("pressed", get_tree().get_root().get_node ("Controller/Control"), "_on_special_pressed")
	assignment = unit
	parent.selectedUnit = assignment
	active = true
	origin = position
	pass

func _process(delta):
	if active:
		#print (assignment.stats.name + " " + str(assignment.atb_val))
		if assignment.atb_val >= 100:
			#print ("heeheehaha")
			#position.y -= delta
			var tween = get_node ("Tween")
			tween.interpolate_property(self, "position",
				null, Vector2(position.x, position.y-256), 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			active = false
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



