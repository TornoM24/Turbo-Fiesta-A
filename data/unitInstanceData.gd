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

func initialize (prefab):
	self.stats = prefab.unitDict.stats
	self.stats.mhp = prefab.unitDict.stats.hp
	self.stats.mmp = prefab.unitDict.stats.mp
	self.stats.name = prefab.unitDict.name
	self.unitName = prefab.unitName
	return self

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
