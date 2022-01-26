extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var source
var eff
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func process(delta):
	pass

func init (effect):
	eff = effect
	print (eff.length)
	get_node ("Progress").value = eff.length
	get_node ("Progress").max_value = eff.maxLength
	get_node ("Progress").texture_under = load ("res://gfx/icons/buff/" + effect.effectType + "_buff.png")
	#get_node ("Progress").texture_progress = load ("res://gfx/icons/buff/" + effect.effectType + "_buff.png")
	#get_node ("Full/Name").bbcode_text = "Source: " + source
	var desc = get_node ("Full/Explanation")
	var dur = get_node ("Full/Duration")
	dur.bbcode_text = "Duration Remaining:\n" + str (effect.length) + "s ◷"
	if effect.id == "stat_buff":
		desc.bbcode_text = "A sharpened mind grants a [color=red]" + str (effect.power) + "%[/color] increase to " + effect.effectType.to_upper() + "."

func _on_Button_mouse_entered():
	modulate = Color (1.2,1.2,1.2,1)
	get_node("Full").visible = true
	pass # Replace with function body.


func _on_Button_mouse_exited():
	modulate = Color (1,1,1,1)
	get_node("Full").visible = false
	pass # Replace with function body.
