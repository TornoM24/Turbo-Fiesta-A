extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var working = true
var ability_dict = {
	"attack_basic_attack":{
		"name": "Attack",
		"id":"attack_basic_attack",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"elements": ["physical"],
				"scaling": ["atk"],
				"power": 100,
				"acc": 100,
			}
		]
	},
	"attack_crimson_saber_hiro":{
		"name": "[Hiro] Crimson Saber",
		"id":"attack_crimson_saber_hiro",
		"type":"phys",
		"desc": "Strikes a single enemy, dealing fire/physical damage.",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"elements": ["physical","fire"],
				"scaling": ["atk"],
				"power": 100,
				"acc": 100,
			}
		]
	},
	"buff_scarlet_blaze":{
		"name": "[Hiro] Scarlet Blaze",
		"id":"buff_scarlet_blaze",
		"type":"phys",
		"desc": "Increases SPD by 50% and increases ATK by 25% for 5 turns.",
		"cost": 10,
		"effects": [
			{
				"type": "buff",
				"target": "self",
				"param": "SPD",
				"power": 50
			},
			{
				"type": "buff",
				"target": "self",
				"param": "ATK",
				"power": 25
			}
		]
	},
	"buff_all_heal_hiro":{
		"name": "[Hiro] 'Don't die on me!'",
		"id":"buff_all_heal_hiro",
		"type":"white",
		"desc": "Heals all allies slightly.",
		"cost": 10,
		"effects": [
			{
				"type": "healing",
				"target": "all allies",
				"scaling" : ["wis","int"],
				"power": 75
			}
		]
	},
	"attack_stardust_ray_stella":{
		"name": "[Stella] Stardust Ray",
		"id":"attack_stardust_ray_stella",
		"type":"ranged",
		"desc": "Shoots an enemy, dealing light/magic damage.",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"scaling" : ["int"],
				"elements": ["magic","light"],
				"power": 100,
				"acc": 100,
			}
		]
	},
	"spell_pur":{ #Pur, Pura, Purafa, Purafaca, Purafacta
		"name": "Pur",
		"id":"spell_pur",
		"type":"white",
		"desc": "Heals a target for a slight amount of health.",
		"cost": 5,
		"effects": [
			{
				"type": "healing",
				"target": "single",
				"scaling" : ["wis","int"],
				"power": 100,
			}
		]
	}
}

var equip_dict = {
	"hiro_heirloom":{
		"name": "Hiro's Heirloom Medallion",
		"desc": "A medallion passed down through Hiro's family. Contains a picture of his parents.",
		"stats": {
			"hp":10,
			"mp":10,
			"spd":5,
			"def":1
		},
		"effects":[
			{
				"type":"restoration",
				"resource":"hp",
				"power":5
			}
		]
	}
}

#Lists data locations for all units in the game
var unit_list = {
	"allies": {
		"hiro": "res://data/unit/hiro/data.tscn"
	},
	"enemies": {
		"geode": "res://data/unit/enemy/geode/data.tscn"
	}
}
#Player's formation; this is the default configuration to prevent bugs.
var formation = []
var party = []
var partyPosition = Vector2(0,0)
var inventory = []
# Called when the node enters the scene tree for the first time.

func fabricate (name):
	var inst = load ("res://data/unitInstanceData.tscn").instance()
	add_child(inst.initialize (load("res://data/unit/"+name+"/"+name+"_data.tscn").instance()))
	inst.name = inst.unitName+"_data"
	#inst.updateStats ("atk",10)
	return inst

func _ready():
	print ("singleton Master loaded")
	party = [fabricate("hiro"),fabricate("stella")]
	formation = [[-1,-1,-1],[-1,0,1],[-1,-1,-1]]
	print (get_node("hiro_data").name)
	pass # Replace with function body.

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
