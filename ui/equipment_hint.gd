extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var yOffset = 0
var sceneBase
var freePath
# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_node ("Tween")
	tween.interpolate_property(self, "modulate",
		Color (1,1,1,0), Color (1,1,1,1), 0.2,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pause_mode = Node.PAUSE_MODE_PROCESS


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generateTip (item):
	get_node ("Panel/Panel/Sprite").texture = load("res://gfx/equip/"+item.id+".png")
	var stars = ""
	for x in range (0, item.cost):
		stars += "◉"
	get_node ("Panel/ItemName").bbcode_text = item.itemName + " " + stars 
	get_node ("Panel/ItemName/RichTextLabel").bbcode_text = "Cost : " + str (item.cost)
	var d = (load ("res://ui/panel_set.tscn").instance())
	get_node("Panel/ScrollContainer/Control").add_child (d)
	d.setText ("DESCRIPTION",item.desc)
	d.position = Vector2(0, 20+yOffset)
	d.get_node ("Panel").rect_size.y += 128
	d.get_node ("Panel/ability_desc").rect_size.y += 128
	yOffset+= 256
	
	var f = (load ("res://ui/panel_set.tscn").instance())
	get_node("Panel/ScrollContainer/Control").add_child (f)
	f.setText ("STAT BOOSTS",item.desc)
	f.position = Vector2(0, 20+yOffset)
	var statSize = 0
	var statText = ""
	for x in item.stats.keys():
		statText += "Increases " + Master.get_full (x) + " + [color=lime]" + str(item.stats[x]) + "\n[/color]"
		statSize += 20
	yOffset+= statSize + 128
	
	f.get_node ("Panel/ability_desc").rect_size.y = statSize
	f.get_node ("Panel/ability_desc").bbcode_text = statText
	

	for x in item.effects:
		var g = (load ("res://ui/panel_set.tscn").instance())
		get_node("Panel/ScrollContainer/Control").add_child (g)
		g.setText ("EFFECT",item.desc)
		g.position = Vector2(0,yOffset)
		statText = " "
		if x.type == "restoration":
			statText = "Restores " + x.resource + " by " + str(x.power) + " every 5 seconds."
		g.get_node ("Panel/ability_desc").bbcode_text = statText
		yOffset+= 128
	get_node ("Panel/ScrollContainer/Control").rect_min_size.y = yOffset + 20
	pass

func _on_Button_pressed():
	get_node (freePath).pause_mode = PAUSE_MODE_PROCESS
	queue_free()
	pass # Replace with function body.
