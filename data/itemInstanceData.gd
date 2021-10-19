extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var stats = {}
var bonusStats = {}
var effects = []
var level = 1
var xp = 0

var id
var itemName = "stupid sword"

func save ():
	var save_dict = {
		"itemName" : itemName,
		"stats": stats,
		"level": level,
		"bonusStats": bonusStats,
		"effects": effects,
		"id":id
	}
	return save_dict

func load_data(data):
	#name = itemName+"_data"
	itemName = data["itemName"]
	id = data["id"]
	stats = data["stats"]
	level = data["level"]
	bonusStats = data["bonusStats"]
	effects = data["effects"]
	return self

func initialize (prefab):
	level = 1
	self.stats = prefab.stats
	self.effects = prefab.effects
	self.itemName = prefab.name
	self.id = prefab.id
	self.name = itemName + "_data"
	return self

func loadBonuses():
	pass

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
