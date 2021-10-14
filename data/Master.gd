extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var working = true
var ability_dict = {
	"attack_basic_attack":{
		"name": "Attack",
		"id":"attack_basic_attack",
		"type":"phys",
		"icon":"sword",
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
		"icon":"sword",
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
		"icon":"wht_mag",
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
		"icon":"shoot",
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
		"icon":"wht_mag",
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

var effect_dict = {
	
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
var partyPosition = Vector2()
var inventory = []
# Called when the node enters the scene tree for the first time.
func save():
	var unitInstances = []
	for x in party:
		unitInstances.append (x.save())
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"x" : partyPosition.x,
		"y" : partyPosition.y,
		"party" : unitInstances,
		"formation": formation,
		"inventory": inventory,
	}
	return save_dict

func load_game():
	for x in get_children():
		#print ("clearing " + x.name)
		x.queue_free()
		remove_child(x)
		#print ("why is " + x.name)
	#for x in get_children():
		#print ("why is " + x.name)
	self.party.clear()
	var save_game = File.new()
	if not save_game.file_exists("res://save/savegame.save"):
		return # Error! We don't have a save to load.
	save_game.open("res://save/savegame.save", File.READ)
	#while save_game.get_position() < save_game.get_len():
	var node_data = parse_json(save_game.get_as_text())
	for i in node_data.keys():
			if i == "filename" or i == "parent":
				continue
			elif i == "party":
				for j in node_data.party:
					var inst = load ("res://data/unitInstanceData.tscn").instance()
					self.add_child(inst.load_data(j))
					print ("is " + inst.unitName)
					inst.name = inst.unitName+"_data"
					print ("instancing and placing " + inst.name)
					Master.party.append (inst)
			elif i == "x":
				partyPosition.x = node_data.x
			elif i == "y":
				partyPosition.y = node_data.y
			else:
				print ("loading property " + i)
				self.set (i,node_data[i])
		
func save_game():
	print ("attempting to save...")
	var save_game = File.new()
	save_game.open("res://save/savegame.save", File.WRITE)
	save_game.store_string(to_json(save()))
	save_game.close()
	print ("successfully saved.")

func new_game ():
	party = [fabricate("hiro"),fabricate("stella")]
	formation = [[-1,-1,-1],[-1,0,1],[-1,-1,-1]]
	save_game()
	
func fabricate (name):
	var inst = load ("res://data/unitInstanceData.tscn").instance()
	add_child(inst.initialize (load("res://data/unit/"+name+"/"+name+"_data.tscn").instance()))
	inst.name = inst.unitName+"_data"
	#inst.updateStats ("atk",10)
	return inst

func _ready():
	print ("singleton Master loaded successfully")
	#print (get_node("hiro_data").name)
	pass # Replace with function body.

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
