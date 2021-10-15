extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var yOffset = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	print ("it is done")
	pause_mode = Node.PAUSE_MODE_PROCESS
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generateTip (ability):
	get_node ("Panel/AbilityName").bbcode_text = ability.name + " [Mana Cost : [color=#00c8ff]" + str(ability.cost) + "[/color]]"
	var d = (load ("res://ui/panel_set.tscn").instance())
	add_child (d)
	d.setText ("DESCRIPTION",ability.desc)
	d.position = Vector2(0, 20+yOffset)
	yOffset+= 128
	var tipText = ""
	var inc = 0
	for x in ability.effects:
		inc +=1
		if x.type == "damage":
			var scalers = ""
			var elements = ""
			var xinc = 0
			for y in x.scaling:
				xinc += 1
				if xinc>1:
					scalers += "/"+ y 
				else:
					scalers += y
			xinc = 0
			for z in x.elements:
				xinc += 1
				if xinc>1:
					elements += "/"+ z
				else:
					elements += z
			scalers=scalers.to_upper()
			elements=elements.to_upper()
			if x.target == "single":
				tipText = "Deals [color=red]" + str(x.power) + "[/color]% of character's [color=green]" + scalers + "[/color] as [color=yellow]" + elements + "[/color] damage to a single target."
			elif x.target == "self":
				tipText = "Deals [color=red]" + str(x.power) + " " + elements + "[/color] damage to self."
		if x.type == "healing":
			var scalers = ""
			var elements = ""
			var xinc = 0
			for y in x.scaling:
				xinc += 1
				if xinc>1:
					scalers += "/"+ y 
				else:
					scalers += y
			xinc = 0
			scalers=scalers.to_upper()
			if x.target == "single":
				tipText = "Heals a target by [color=green]" + str(x.power) + "[/color]% of character's [color=green]" + scalers + "[/color]."
			elif x.target == "all allies":
				tipText = "Heals [color=green]" + str(x.power) + "[/color]% of character's [color=green]" + scalers + "[/color] to all allies."
		var y = (load ("res://ui/panel_set.tscn").instance())
		add_child (y)
		y.setText ("EFFECT "+ str (inc), tipText)
		y.position = Vector2(0, 20+yOffset)
		yOffset += 128


func _on_Button_pressed():
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.
