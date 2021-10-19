extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var stats = {}
var bonusStats = {
		"mhp" : 0,
		"mmp" : 0,
		"hp" : 0,
		"mp" : 0,
		"atk" : 0,
		"def" : 0,
		"int" : 0,
		"wis" : 0,
		"apt" : 0,
		"spd" : 0,
		"luk" : 0
	}
var equipment = []
var abilities = []
var level = 1
var xp = 0
var toNext = 10
var equipAbilities = []
var prefab
var baseStats = {}
var unitName = "Aou Mogis"


func level_up():
	level += 1
	toNext = round( 0.04 * (pow(level, 3)) + 0.8 * (pow(level, 3)) + 2 * level)
	for stat in stats.keys():
		if !stat=="hp" and !stat=="mp" and !stat=="unitName" and !stat=="name":
			bonusStats[stat] += round(baseStats[stat]/10)
			stats[stat] += bonusStats[stat]
			if !stats.hp<=0:
				stats.hp = stats.mhp
				stats.mp = stats.mmp
	return level

func give_xp (amount):
	xp += amount
	while xp>=toNext:
		level_up()
	return xp

func save ():
	var itemInstances = []
	for x in equipment:
		itemInstances.append (x.save())
		print ("saved " + x.itemName)
	var save_dict = {
		"unitName" : unitName,
		"stats": stats,
		"level": level,
		"bonusStats": bonusStats,
		"baseStats": baseStats,
		"equipment": itemInstances,
		"abilities": abilities,
		"xp": xp,
	}
	return save_dict

func load_data(data):
	#name = unitName+"_data"
	unitName = data["unitName"]
	stats = data["stats"]
	level = data["level"]
	bonusStats = data["bonusStats"]
	baseStats = data["baseStats"]
	#equipment = data["equipment"]
	abilities = data["abilities"]
	xp = data["xp"]
	toNext = round( 0.04 * (pow(level, 3)) + 0.8 * (pow(level, 3)) + 2 * level)
	return self

func initialize (prefab):
	self.baseStats = prefab.unitDict.stats
	self.stats = prefab.unitDict.stats
	self.stats.mhp = prefab.unitDict.stats.hp
	self.stats.mmp = prefab.unitDict.stats.mp
	self.stats.name = prefab.unitDict.name
	self.unitName = prefab.unitName
	level = 1
	toNext = round( 0.04 * (pow(level, 3)) + 0.8 * (pow(level, 3)) + 2 * level)
	return self

func updateStats (parameter, amount):
	stats[parameter] += amount
	pass

func addPermanentAbility (reference):
	stats["abilities"].append (reference)
	pass

func equip (item):
	add_child (item)
	equipment.append (item)
	print ("successfully equipped " + item.itemName + " to unit " + unitName)

func loadBonuses():
	pass

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
