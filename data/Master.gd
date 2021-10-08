extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ability_dict = {
	"attack_crimson_saber_hiro":{
		"name": "[Hiro] Crimson Saber",
		"desc": "Manifests Hiro's Crimson Saber, then strikes once, dealing light fire/physical damage.",
		"effects": [
			{
				"type": "damage",
				"elements": ["physical","fire"],
				"power": 100,
				"acc": 100,
				"cost": 0
			}
		]
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print ("singleton Master loaded")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
