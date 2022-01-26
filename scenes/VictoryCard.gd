extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var targetValue = 0
var currentValue = 0
var trueValue = 0.0
var targetLevel = 0.0
var currentLevel = 0
var initValue = 0
var maxValue = 0
var animTimer = 0
var assignment
onready var xpBar = get_node ("Panel/EXPBar")
# Called when the node enters the scene tree for the first time.
func _ready():
	#modulate.a = 0
	pass # Replace with function body.

func display (m):
	maxValue = m
	#xpBar.max_value = maxValue

func calc_next (level):
	var next = round( 0.04 * (pow(level, 3.0)) + 0.8 * (pow(level, 2.0)) + 2 * level)
	#next = round(10 + (float(pow (2, level))))
	return next

func calc_final (level):
	var next = 0
	for x in range (0,level):
		next += round( 0.04 * (pow(level, 3.0)) + 0.8 * (pow(level, 2.0)) + 2 * level)
	return next

func start (C, T, tV, iV):
	targetValue = tV
	targetLevel = T
	currentLevel = C
	trueValue = currentLevel
	initValue = iV
	currentValue = initValue
	speed = 5/(targetLevel + 2 - currentLevel)
	get_node ("Panel/LevelUp").modulate.a = 0

func true_start():
	if currentLevel == targetLevel:
		complete = true
		tween.interpolate_property(get_node("Panel/EXPBar"), "value",
			0.0, (assignment.xp / assignment.toNext) * 100, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
	else:
		tween.interpolate_property(get_node("Panel/EXPBar"), "value",
			0.0, 100.0, speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		
var complete = false
var speed = 0.5
onready var tween = get_node ("Tween")
func _process(delta):
	
	speed = 5/(targetLevel + 2 - currentLevel)
	maxValue = calc_next (currentLevel)
	var label = get_node("Panel/EXPBar/EXPLabel")
	var nLabel = get_node("Panel/EXPBar/EXPLabelNext")
	var lLabel = get_node("Panel/EXPBar/LVLabel")
	label.bbcode_text = "[right]"+ str (initValue) + "+[color=lime]" + str(int(targetValue))
	nLabel.bbcode_text = "[right]To Next Level: "+ str (round(maxValue - (maxValue * (xpBar.value / 100))))
	lLabel.bbcode_text = "LV"+ str(currentLevel)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_all_completed():
	if !complete:
		currentLevel +=1
		get_node ("Panel/LevelUp").modulate.a = 1
		if currentLevel == targetLevel:
			#get_node ("Panel/LevelUp").modulate.a = 1
			var final = calc_final (targetLevel)
			tween.interpolate_property(get_node("Panel/EXPBar"), "value",
				0.0, (assignment.xp / assignment.toNext) * 100, speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
			complete = true
		elif currentLevel < targetLevel:
			get_node ("Panel/LevelUp").modulate.a = 1
			tween.interpolate_property(get_node("Panel/EXPBar"), "value",
				0.0, 100.0, speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
	pass # Replace with function body.


func _on_Timer_timeout():
	true_start()
	pass # Replace with function body.
