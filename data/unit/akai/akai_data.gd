extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var ref_Master = get_node ("/root/Master")
var bMas = Master.ability_dict
var unitName = "akai"
var unitDict = {
	"name" : "Akai",
	"title" : "time-lost swordsman",
	"bio" : "A wanderer who BLUE aba dee aba dieeee aba dee aba dieee abadeeabadie",
	"stats": {
		"hp" : 25,
		"mp" : 25,
		"atk" : 11,
		"def" : 3,
		"int" : 2,
		"wis" : 3,
		"apt" : 5,
		"spd" : 99,
		"luk" : 10
	},
	"abilities": [bMas["buff_super_atk"],bMas["attack_iai"],bMas["attack_snowpetal"]]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
