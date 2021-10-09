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
		"desc": "Manifests Hiro's Crimson Saber, then strikes once, dealing weak fire/physical damage.",
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
var formation = [["empty","empty","empty"],["empty","hiro","empty"],["empty","empty","empty"]]

# Called when the node enters the scene tree for the first time.
func _ready():
	print ("singleton Master loaded")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
