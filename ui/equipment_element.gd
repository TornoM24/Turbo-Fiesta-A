extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var location 
var item 
# Called when the node enters the scene tree for the first time.
func _ready():
	connect ("pressed", get_tree().get_root().get_node("partyview"), "_on_item_pressed", [self])
	pass # Replace with function body.

func init (item):
	self.item = item
	get_node("Panel/Sprite").texture = load ("res://gfx/equip/"+item.id+ ".png")
	get_node("Panel/RichTextLabel").bbcode_text = item.itemName
	get_node("Panel/RichTextLabel2").bbcode_text = "[right]◉" + str (item.cost)

func _process(delta):
	if !visible:
		queue_free()
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
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().sort_equip (self)
			BUTTON_RIGHT:
				var hint = load ("res://ui/equipment_hint.tscn").instance()
				hint.generateTip (item)
				hint.freePath = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_path()
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().add_child (hint)
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().pause_mode = PAUSE_MODE_STOP
	pass # Replace with function body.
