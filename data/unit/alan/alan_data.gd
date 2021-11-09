extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var ref_Master = get_node ("/root/Master")
var bMas = Master.ability_dict
var unitName = "alan"
var unitDict = {
	"name" : "Alan",
	"title" : "time-lost struggler",
	"bio" : "A wanderer who BLUE aba dee aba dieeee aba dee aba dieee abadeeabadie",
	"stats": {
		"hp" : 25,
		"mp" : 25,
		"atk" : 11,
		"def" : 3,
		"int" : 2,
		"wis" : 3,
		"apt" : 5,
		"spd" : 9,
		"luk" : 10
	},
	"abilities": [bMas["attack_iai_alan"]]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
