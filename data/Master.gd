extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var working = true
var ability_dict = {
	"attack_basic_attack":{
		"name": "Attack",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"elements": ["physical"],
				"power": 100,
				"acc": 100,
			}
		]
	},
	"attack_crimson_saber_hiro":{
		"name": "[Hiro] Crimson Saber",
		"desc": "Manifests Hiro's Crimson Saber, then strikes a single enemy, dealing weak fire/physical damage.",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"elements": ["physical","fire"],
				"power": 100,
				"acc": 100,
			}
		]
	},
	"buff_scarlet_blaze":{
		"name": "[Hiro] Scarlet Blaze",
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
	"attack_stardust_ray_stella":{
		"name": "[Stella] Stardust Ray",
		"desc": "Deploys a Starbit to deal weak light/magic damage to a single enemy.",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"elements": ["magic","light"],
				"power": 100,
				"acc": 100,
			}
		]
	}
}

var equip_dict = {
	"hiro_heirloom":{
		"name": "Hiro's Heirloom Medallion",
		"desc": "A medallion passed down through Hiro's family. Contains a picture of my fat fucking dick",
		"stats": {
			"hp":10,
			"mp":10,
			"spd":5,
			"def":1
		},
		"effects":{
			"restoration":{
				"resource":"hp",
				"power":5
			}
		}
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
func _ready():
	print ("singleton Master loaded")
	party = ["hiro","stella"]
	formation = [["empty","empty","empty"],["empty","hiro","stella"],["empty","empty","empty"]]
	pass # Replace with function body.

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
