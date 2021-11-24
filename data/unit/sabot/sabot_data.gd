extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var ref_Master = get_node ("/root/Master")
var bMas = Master.ability_dict
var unitName = "sabot"
var unitDict = {
	"name" : "Sabot",
	"title" : "tormented prototype",
	"class" : "Durable Breaker",
	"types" : "Artillery, Debuffer, Fighter",
	"bio" : "A humanoid weapon constructed (or modified?) by the Almerian Federation as part of a series of prototype shock assault experiments.\nThey were once something- or someone, but their identity was lost the moment they became a weapon, an issue that Sabot seems to have no qualms about.\nYet, flashes of a haunted past yet remain, swirling about their ever-online fire control systems, and that attitude may just yet change with time...",
	"weapon" : "This particular unit is equipped with several anti-personnel autocannons and an enormous metal jaw grafted onto their right arm, which appears to move semi-independently. Within the cruel metal jaws lies a lethally sharp spiked rod that not only brutally impales its foes, but obliterates armor with frightening efficacy, albeit with an extreme weight imbalance, a result of the unrefined Almerian mass-produced weapons development at the time of Sabot's manufacturing.",
	"facts": "Favorite food: None (Fuel?)",
	"specialRanged": true,
	"stats": {
		"hp" : 40,
		"mp" : 30,
		"atk" : 10,
		"def" : 10,
		"int" : 2,
		"wis" : 4,
		"apt" : 3,
		"spd" : 4,
		"luk" : 5
	},
	"abilities": [bMas["attack_interceptor"],bMas["buff_light_atk"]]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
