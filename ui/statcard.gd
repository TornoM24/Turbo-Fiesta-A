extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node ("Full").hide()
	pass # Replace with function body.

func _process(delta):
	if modulate.a <= 0:
		print ("destroying stat card")
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init (stat, unit):
	var stats = unit.stats
	get_node ("Title").bbcode_text = ""+Master.get_full (stat)
	if stat != "mhp" and stat!= "mmp":
		get_node ("Full/Total").bbcode_text = "Base : [color=yellow]" + str(unit.baseStats[stat]) + "[/color]"
		if stat == "hp":
			get_node ("Full/Total").bbcode_text = "Base : [color=yellow]" + str(unit.baseStats["mhp"]) + "[/color]"
		if stat == "mp":
			get_node ("Full/Total").bbcode_text = "Base : [color=yellow]" + str(unit.baseStats["mmp"]) + "[/color]"
	
	get_node ("Full/Equip").bbcode_text = "Equipment : [color=lime]" + str(unit.bonusStats[stat]) + ""
	get_node ("Full/Explanation").bbcode_text = Master.get_full ("e"+stat)
	if stat != "mhp" and stat!= "mmp":
		get_node ("RichTextLabel").bbcode_text = "[right]" + str(stats[stat] + unit.bonusStats[stat]) + ""
	else:
		get_node ("RichTextLabel").bbcode_text = "[right]" + str(stats[stat]) + ""

func _on_Button_mouse_entered():
	modulate = Color (1.2,1.2,1.2,1)
	get_node("Full").visible = true
	pass # Replace with function body.


func _on_Button_mouse_exited():
	modulate = Color (1,1,1,1)
	get_node("Full").visible = false
	pass # Replace with function body.
