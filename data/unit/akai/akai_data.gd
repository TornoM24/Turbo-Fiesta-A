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
	"class" : "High-speed Assassin",
	"types" : "Assassin, Fighter",
	"bio" : "A wanderer hailing from somewhere in the East. According to himself, he is a seasoned swordsman and a practitioner of a long-lost meditative discipline borne only by the most steel-hearted of warriors, although his drunkard tendencies and questionable (albeit certainly effective) fighting style causes a bit of confusion about his peers.\nIronically enough, despite these flaws, he is rather charismatic, and likeable enough, if not for the constant smell of Vallant brew lingering on his breath.",
	"weapon": """FORAGED BLADE: A beautifully-forged curved sword from a distant land forgotten with time. 
Through an esoteric and long-gone process, the sharpened edge of the blade was 
forged to excel in slicing through unprotected flesh with its smooth cutting edge. 
Found in Akai's possession, though when questioned on the circumstances of its acquisition
he says he's simply 'always had it', and to 'stop asking questions.'""",
	"facts": "Favorite food: Peaches",
	"nFrames": [11],
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
