extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var location 
var item 
# Called when the node enters the scene tree for the first time.
func _ready():
	#connect ("pressed", get_tree().get_root().get_node("partyview"), "_on_item_pressed", [self])
	pass # Replace with function body.

var glow = load ("res://pixel_panel_inwards_glow.theme")
var plain = load ("res://pixel_panel.theme")
onready var panel = get_node ("Panel")

func init (item):
	self.item = item
	get_node("Panel/Sprite").texture = load ("res://gfx/equip/"+item.id+ ".png")
	get_node("Panel/RichTextLabel").bbcode_text = item.itemName
	get_node("Panel/RichTextLabel2").bbcode_text = "[right]◉" + str (item.cost)
	if location == "inventory":
		panel.theme = plain
	elif location == "equipment":
		panel.theme = plain
	#queue_enter()
	
func _process(delta):
	#print (str (global_position))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# 6 getparents
#var isGrabbed = false

func _on_DetailButton_gui_input(event):	
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				self.queue_kill()
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().sort_equip (self)
			BUTTON_RIGHT:
				var hint = load ("res://ui/equipment_hint.tscn").instance()
				hint.generateTip (item)
				hint.freePath = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_path()
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().add_child (hint)
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().pause_mode = PAUSE_MODE_STOP
	pass # Replace with function body.
onready var tween = get_node("Tween")
var deleting = false
var new = false
func queue_kill():
	deleting = true
	get_node ("Panel/DetailButton").disabled = true
	get_node ("Panel/DetailButton").hide()
	#hide()
	tween.interpolate_property(self, "position",
		null, position + Vector2(0, -20), 0.1,
	Tween.TRANS_QUART, Tween.EASE_IN)
	tween.start()
	tween.interpolate_property(self, "modulate",
		null, Color (1,1,1,0), 0.1,
	Tween.TRANS_QUART, Tween.EASE_IN)
	tween.start()
	pass

func queue_enter():
	#hide()
	show()
	var tar = position+ Vector2(0, 20)
	var org = position+ Vector2(0, -20)
	tween.interpolate_property(self, "position",
		org, tar,  0.1,
	Tween.TRANS_QUART, Tween.EASE_IN)
	tween.start()
	tween.interpolate_property(self, "modulate",
		null, Color (1,1,1,1),  0.1,
	Tween.TRANS_QUART, Tween.EASE_IN)
	tween.start()
	new = false
	
func _on_Tween_tween_all_completed():
	if deleting:
		hide()
		queue_free()
	pass # Replace with function body.
