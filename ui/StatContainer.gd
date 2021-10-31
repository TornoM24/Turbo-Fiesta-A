extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var stat = "x"
var target = 0
var val = 0
var parent
var unit
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func check ():
	if target > val:
		get_node ("StatLabel").bbcode_text = Master.get_full(stat) + " " + str(val) + " ▸[color=lime] " + str (target)
	else:
		get_node ("StatLabel").bbcode_text = Master.get_full(stat) + " " + str(val) + " ▸ " + str (target)
		
func init(stat, value):
	self.stat = stat
	target = value
	val = value
	check()

func change (x):
	target += x
	check()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlusButton_pressed():
	if unit.spendable >= 1:
		if stat == "mhp" or stat == "mmp":
			change (5)
		else:
			change (1)
		unit.spendable -=1
		parent.update_sp (unit.spendable)
	check()
	pass # Replace with function body.


func _on_MinusButton_pressed():
	if unit.stats[stat] < target:
		if stat == "mhp" or stat == "mmp":
			change (-5)
		else:
			change (-1)
		unit.spendable += 1
		parent.update_sp (unit.spendable)
	check()
	pass # Replace with function body.
