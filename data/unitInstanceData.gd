extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var stats = {}
var bonusStats = {}
var equipment = []
var abilities = []

var equipAbilities = []

var unitName = "Aou Mogis"
# Called when the node enters the scene tree for the first time.
func updateStats (parameter, amount):
	stats[parameter] += amount
	pass

func addPermanentAbility (reference):
	stats["abilities"].append (reference)
	pass

func loadBonuses():
	pass

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
