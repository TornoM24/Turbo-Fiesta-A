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
var dict = {
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
var baseStats = {
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
var unitName = "Aou Mogis"
var sp = 0
var spendable = 0
var cost = 0
var maxCost = 0
var title
var statusEffects = []
func level_up():
	level += 1
	xp -= toNext
	toNext = round( 0.04 * (pow(level, 3.0)) + 0.8 * (pow(level, 2.0)) + 2 * level)
	#toNext = round(10 + (float(pow (2, level))))
	for stat in stats.keys():
		if !stat=="mhp" and !stat=="mmp" and !stat=="unitName" and !stat=="name":
			#bonusStats[stat] += round(baseStats[stat]/10)
			if stat == "hp" :
				baseStats["hp"] += ceil(dict[stat]/10)
				stats["mhp"] = baseStats[stat]
			elif stat == "mp":
				baseStats["mp"] += ceil(dict[stat]/10)
				stats["mmp"] = baseStats[stat]
			else:
				#print ("value of " + stat + " " + str(dict[stat]))
				baseStats[stat] += ceil(dict[stat]/10)
				stats[stat] = baseStats[stat]
	update_self()
	if !stats.hp<=0:
		stats.hp = stats.mhp
		stats.mp = stats.mmp
	sp += 2
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
		"dict" : dict,
		"prefab" : prefab,
		"equipment": itemInstances,
		"abilities": abilities,
		"cost" : cost,
		"title" : title,
		"statusEffects": statusEffects,
		"xp": xp,
		"sp": sp
	}
	return save_dict

func load_data(data):
	#name = unitName+"_data"
	prefab = data["prefab"]
	unitName = data["unitName"]
	stats = data["stats"]
	level = data["level"]
	bonusStats = data["bonusStats"]
	baseStats = data["baseStats"]
	dict = data["dict"]
	#equipment = data["equipment"]
	abilities = data["abilities"]
	statusEffects = data ["statusEffects"]
	title = data ["title"]
	sp = data ["sp"]
	cost = data ["cost"]
	maxCost = data.stats.apt
	for x in data["abilities"]:
		print ("ability " + x.name)
	xp = data["xp"]
	toNext = round( 0.04 * (pow(level, 3.0)) + 0.8 * (pow(level, 2.0)) + 2 * level)
	#toNext = round(10 + (float(pow (2, level))))
	return self
var details = {}
func initialize (prefab):
	self.prefab = prefab.unitDict.duplicate()
	self.baseStats = prefab.unitDict.stats.duplicate()
	self.stats = prefab.unitDict.stats.duplicate()
	self.dict = prefab.unitDict.stats.duplicate()
	self.stats.mhp = prefab.unitDict.stats.hp
	self.stats.mmp = prefab.unitDict.stats.mp
	self.stats.name = prefab.unitDict.name
	self.abilities = prefab.unitDict.abilities
	self.unitName = prefab.unitName
	self.sp = 10
	self.cost = 0
	self.maxCost = prefab.unitDict.stats.apt
	self.title = prefab.unitDict.title
	level = 1
	toNext = round( 0.04 * (pow(level, 3.0)) + 0.8 * (pow(level, 2.0)) + 2 * level)
	#toNext = round(10 + (float(pow (2, level))))
	return self

func updateStats (parameter, amount):
	stats[parameter] += amount
	pass

func addPermanentAbility (reference):
	stats["abilities"].append (reference)
	pass
func update_self ():
	cost = 0
	for stat in bonusStats.keys():
		bonusStats[stat] = 0
		if stat == "hp":
			stats.hp = baseStats[stat]
			stats.mhp = baseStats[stat]
		elif stat == "mp":
			stats.mp = baseStats[stat]
			stats.mmp = baseStats[stat]
	for equip in self.equipment:
		cost += equip.cost
		for stat in equip.stats.keys():
			#print ("increasing stat " + stat + " by " + str (equip.stats[stat]) + " for item " + equip.itemName)
			if stat == "hp":
				bonusStats.mhp += equip.stats[stat]
				#stats.hp += equip.stats[stat]
				stats.mhp += equip.stats[stat]
			elif stat == "mp":
				bonusStats.mmp += equip.stats[stat]
				#stats.mp += equip.stats[stat]
				stats.mmp += equip.stats[stat]
			else:
				bonusStats [stat] += equip.stats[stat]
func equip (item):
	#cost += item.cost
	add_child (item)
	equipment.append (item)
	update_self()
	print ("successfully equipped " + item.itemName + " to unit " + unitName)

func unequip (item):
	#cost -= item.cost
	equipment.erase (item)
	for stat in bonusStats.keys():
		bonusStats[stat] = 0
	update_self()

func loadBonuses():
	pass

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
