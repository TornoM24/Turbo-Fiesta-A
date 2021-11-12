extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var targetValue = 0
var currentValue = 0
var trueValue = 0
var targetLevel = 0
var currentLevel = 0
var initValue = 0
var maxValue = 0
var animTimer = 0
onready var xpBar = get_node ("Panel/EXPBar")
# Called when the node enters the scene tree for the first time.
func _ready():
	#modulate.a = 0
	pass # Replace with function body.

func display (m):
	maxValue = m
	#xpBar.max_value = maxValue

func calcNext (level):
	return round( 0.04 * (pow(level, 3)) + 0.8 * (pow(level, 3)) + 2 * level)

func start (C, T, tV, iV):
	targetValue = tV
	targetLevel = T
	currentLevel = C
	trueValue = currentLevel
	initValue = iV
	currentValue = initValue

func _process(delta):
	maxValue = calcNext (currentLevel)
	xpBar.max_value = float(currentValue / maxValue)
	xpBar.value = currentValue
	if trueValue < targetValue:
		if currentValue < maxValue:
			animTimer += delta
			if animTimer >= 0.001:
				currentValue += 1
				trueValue += 1
				animTimer = 0
		else:
			currentValue = 0
			currentLevel += 1
	var label = get_node("Panel/EXPBar/EXPLabel")
	var nLabel = get_node("Panel/EXPBar/EXPLabelNext")
	var lLabel = get_node("Panel/EXPBar/LVLabel")
	label.bbcode_text = "[right]"+ str (initValue) + "+[color=lime]" + str(int(trueValue))
	nLabel.bbcode_text = "[right]To Next Level: "+ str (maxValue)
	lLabel.bbcode_text = "LV"+ str(currentLevel)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
