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
		"name": "Crimson Saber",
		"id":"attack_crimson_saber_hiro",
		"type":"phys",
		"icon":"sword",
		"desc": "Attacks with Hiro's Crimson Saber, dealing physical/fire damage.",
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
	"attack_iai_alan":{
		"name": "Iai Draw",
		"id":"attack_iai_alan",
		"type":"phys",
		"icon":"sword",
		"desc": "Performs a rapid draw, dealing physical damage with a high critical ratio.",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"elements": ["physical"],
				"scaling": ["atk"],
				"power": 100,
				"acc": 200,
			}
		]
	},
	"attack_final_flare_hiro":{
		"name": "Final Flare",
		"id":"attack_final_flare_hiro",
		"type":"ranged",
		"icon":"sword",
		"desc": "Unleashes Hiro's inner power, dealing massive fire damage to both him and the enemy.",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"elements": ["fire"],
				"scaling": ["atk"],
				"power": 1000,
				"acc": 100,
			},
			{
				"type": "damage",
				"target": "self",
				"elements": ["fire"],
				"scaling": ["atk"],
				"power": 9999,
				"acc": 100,
			}
		]
	},
	"buff_scarlet_blaze":{
		"name": "Scarlet Blaze",
		"id":"buff_scarlet_blaze",
		"type":"magic",
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
		"name": "'Don't die on me!'",
		"id":"buff_all_heal_hiro",
		"type":"magic",
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
		"name": "Stardust Ray",
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
	"spell_pur":{ #Pur, Pura, Purada, Purafada, Purafacta
		"name": "Pur",
		"id":"spell_pur",
		"type":"magic",
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
	},
	"spell_flare":{ #Flare, Flara, Flarada, Flarafada, Flarafacta
		"name": "Flare",
		"id":"spell_flare",
		"type":"magic",
		"icon":"blk_mag",
		"desc": "Summons a ball of raw thermal energy, then casts it at the target.\n An elementary spell with numerous uses and a great amount of potential.\n[color=gray]The flame sings its siren song, but only few feel its voice.[/color]",
		"cost": 5,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"scaling" : ["int"],
				"elements" : ["fire"],
				"power": 110,
			}
		]
	},
	"spell_alflare":{ #AlFlare, AlFlara, AlFlarada, AlFlarafada, AlFlarafacta
		"name": "AlFlare",
		"id":"spell_alflare",
		"type":"magic",
		"icon":"blk_mag",
		"desc": "Summons several balls of thermal energy, which are then cast over a large area.\nMost often employed by affiliated mages due to its ease of use\nand incredible area-of-effect.",
		"cost": 13,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"scaling" : ["int"],
				"elements" : ["fire"],
				"power": 90,
			}
		]
	},
	"spell_soul":{ #Soul, Soula, Soulada, Soulafada, Soulafacta
		"name": "Soul",
		"id":"buff_soul",
		"type":"magic",
		"desc": "Increases the damage of the caster's next magic cast slightly.\nThis spell is often used by mages to surprise their foes with a large burst of explosive power.\n[color=red]Power grows, but life wanes. No one notices, though. ",
		"cost": 8,
		"effects": [
			{
				"type": "buff",
				"target": "self",
				"param": "next_cast",
				"power": 25
			},
		]
	},
}
var passive_dict = {
	"affinity_modular":{
		"name":"set name here",
		"id":"affinity_modular"
	}
}

var equip_dict = {
	"hiro_heirloom":{
		"name": "Hiro's Heirloom",
		"id" : "hiro_heirloom",
		"desc": """
			A strange medallion in Hiro's possession, which contains 
			an unusual pebble-sized gemstone that radiates with energy. If 
			touched, the gem shimmers with a vibrant, pulsing crimson light. 
			The nostalgic red shine reminds Hiro of sanguine memories, which he 
			holds dear to his heart.""",
		"stats": {
			"hp":10,
			"def":10
		},
		"effects":[
			{
				"type":"restoration",
				"resource":"hp",
				"power":5
			}
		]
	},
	"alan_foraged_blade":{
		"name": "Foraged Blade",
		"id" : "alan_foraged_blade",
		"desc": """
			A beautifully-forged curved sword from a distant land forgotten with time. 
			Through an esoteric and long-gone process, the sharpened edge of the blade was 
			forged to excel in slicing through unprotected flesh like paper with its smooth cutting edge. 
			Found in Alan's possession, though when questioned he says he's simply 
			'always had it', and to 'stop asking questions.'""",
		"stats": {
			"spd":2,
			"atk":10
		},
		"effects":[
			{
				"type":"ability",
				"misc":"attack_iai_alan"
			}
		]
	},
	"stella_shard_coat":{
		"name": "Shard Coat",
		"id" : "stella_shard_coat",
		"desc": """
			A radiant, white-and-gold hoodie-style coat worn by Stella. 
			The golden embellishments magnify the strength of magical power, and 
			simultaneously appear to react to emotions that coalesce around 
			the wearer by twitching energetically. According to Stella, 
			these implements also approve of her wit, to the tired agreement of her companions.""",
		"stats": {
			"int":4,
			"wis":8
		},
		"effects":[
			{
				"type":"effect",
				"misc":"buff_golden_gleam"
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
		print (x.xp)
		unitInstances.append (x.save())
	var itemInstances = []
	for x in inventory:
		itemInstances.append (x.save())
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"x" : partyPosition.x,
		"y" : partyPosition.y,
		"party" : unitInstances,
		"formation": formation,
		"inventory": itemInstances,
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
	self.inventory.clear()
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
				var toEquip = []
				print (j.keys())
				var equipment = j.equipment
				#print (equipment[0].itemName)
				for k in equipment:
					var item = load ("res://data/itemInstanceData.tscn").instance()
					item = item.load_data(k)
					#inst.add_child (item.load_data(k))
					#print (item.xp)
					print ("instantiated " + inst.unitName + "'s " + item.itemName)
					item.name = k.id
					toEquip.append (item)
					print ("got " + item.itemName)
				for item in toEquip:
					print ("equipped " + item.itemName)
					print (item.xp)
					inst.equip (item)
		elif i == "inventory":
			for j in node_data.inventory:
				var inst = load ("res://data/itemInstanceData.tscn").instance()
				inst = inst.load_data(j)
				self.add_equip(inst)
		elif i == "x":
			partyPosition.x = node_data.x
		elif i == "y":
			partyPosition.y = node_data.y
		else:
			print ("loading property " + i)
			self.set (i,node_data[i])

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)

func save_game():
	print ("attempting to save...")
	var save_game = File.new()
	save_game.open("res://save/savegame.save", File.WRITE)
	save_game.store_string(to_json(save()))
	save_game.close()
	print ("successfully saved.")

func new_game ():
	party = [fabricate("hiro"),fabricate("stella")]
	Master.party[0].equip (give_equipment("hiro_heirloom"))
	formation = [[-1,-1,-1],[-1,0,1],[-1,-1,-1]]
	add_equip (give_equipment ("alan_foraged_blade"))
	save_game()
	
func fabricate (name):
	var inst = load ("res://data/unitInstanceData.tscn").instance()
	add_child(inst.initialize (load("res://data/unit/"+name+"/"+name+"_data.tscn").instance()))
	inst.name = inst.unitName+"_data"
	#inst.updateStats ("atk",10)
	return inst

func give_equipment (name):
	var inst = load ("res://data/itemInstanceData.tscn").instance()
	print ("giving equipment..")
	inst.initialize (equip_dict[name])
	inst.name = name
	#inst.updateStats ("atk",10)
	return inst

func add_equip (inst):
	self.add_child (inst)
	inventory.append (inst)
	print ("appended " + inst.itemName + " successfully")
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
