extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var atb_paused = false
var working = true
var ability_dict = {
	"attack_basic_attack":{
		"name": "Attack",
		"id":"attack_basic_attack",
		"type":"phys",
		"icon":"sword",
		"fx" : "slash",
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
	"attack_snowpetal":{ 
		"name": "Snowpetal",
		"id":"attack_snowpetal",
		"type":"phys",
		"icon":"petal",
		"fx" : "petal",
		"quote" : "Like spring--!",
		"desc": "Strikes a large area with a technique fine enough to cut through petals, dealing physical damage.",
		"cost": 2,
		"effects": [
			{
				"type": "damage",
				"target": "all enemies",
				"elements": ["physical"],
				"scaling": ["atk"],
				"power": 90, #90%
				"acc": 100,
			}
		]
	},
	"buff_super_atk":{
		"name": "Gamer Rage",
		"id":"buff_super_atk",
		"type":"magic",
		"icon":"magic",
		"fx" : "glow",
		"castTime" : 0.1,
		"quote" : "REEEEE",
		"desc": "GOOD LORD IM SO ABSOLUTELY PUMPED RIGHT NOW",
		"cost": 0,
		"effects": [
			{
				"type": "buff",
				"target": "self",
				"param": "atk",
				"power": 999,
				"duration": 10
			},
			{
				"type": "buff",
				"target": "self",
				"param": "def",
				"power": 999,
				"duration": 10
			}
		]
	},
	"attack_scarlet_razor_hiro":{
		"name": "Razorcut",
		"id":"attack_scarlet_razor_hiro",
		"type":"phys",
		"icon":"razor",
		"fx" : "slash",
		"quote" : "Right there!",
		"desc": "Cleaves a target enemy, dealing physical/fire damage.",
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
		"icon":"katana",
		"fx" : "slash",
		"quote" : "Sei!!",
		"desc": "Performs a rapid sword draw, dealing physical damage with a high critical ratio.",
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
		"name": "Bad Move",
		"id":"attack_final_flare_hiro",
		"type":"ranged",
		"icon":"sword",
		"fx" : "slash",
		"desc": "Deals 1 flat physical damage to user.\n[color=gray]Whoops!",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "self",
				"elements": ["physical"],
				"scaling": ["atk"],
				"power": 1,
				"acc": 100,
			}
		]
	},
	"buff_scarlet_blaze":{
		"name": "No Time to Think",
		"id":"buff_scarlet_blaze",
		"type":"magic",
		"icon":"magic",
		"fx" : "glow",
		"quote" : "This is it...!",
		"desc": "User steels their resolve, gaining bonus DEF and ATK and attracting enemy attention.\n[color=gray]\nI won't let it happen again...!",
		"cost": 20,
		"effects": [
			{
				"type": "buff",
				"target": "self",
				"param": "atk",
				"power": 20,
				"duration": 10
			},
			{
				"type": "buff",
				"target": "self",
				"param": "def",
				"power": 30,
				"duration": 10
			}
		]
	},
	"buff_all_heal_hiro":{
		"name": "'One more shot!'",
		"id":"buff_all_heal_hiro",
		"type":"magic",
		"icon":"wht_mag",
		"fx" : "heal",
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
		"name": "Starshot",
		"id":"attack_stardust_ray_stella",
		"type":"ranged",
		"icon":"shoot2",
		"fx" : "shoot",
		"desc": "Shoots an enemy, dealing light/magic damage.\n[color=gray]'Stand still, or I won't be able to miss your vitals!'",
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
		"name": "Recell",
		"id":"spell_pur",
		"type":"magic",
		"icon":"wht_mag",
		"fx" : "heal",
		"desc": "Heals a target for a slight amount of health.\n[color=grey]Palliative eternity. Quaint, but comforting.",
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
		"name": "Ignia",
		"id":"spell_flare",
		"type":"magic",
		"icon":"blk_mag",
		"fx" : "flare",
		"quote" : "Burn to ash!",
		"desc": "Summons a ball of raw thermal energy, then casts it at the target.\nAn elementary spell with numerous uses and a great amount of potential.",
		"cost": 5,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"scaling" : ["int"],
				"elements" : ["fire"],
				"power": 110,
				"acc": 100,
			}
		]
	},
	"spell_alflare":{ #AlFlare, AlFlara, AlFlarada, AlFlarafada, AlFlarafacta
		"name": "Arignia",
		"id":"spell_alflare",
		"type":"magic",
		"icon":"blk_mag",
		"fx" : "flare",
		"quote" : "To call flame!",
		"desc": "Summons several balls of thermal energy, which are then cast over a large area.\nMost often employed by affiliated mages due to its ease of use\nand incredible area-of-effect.",
		"cost": 13,
		"effects": [
			{
				"type": "damage",
				"target": "all enemies",
				"scaling" : ["int"],
				"elements" : ["fire"],
				"power": 90,
				"acc": 100,
			}
		]
	},
	"spell_soul":{ #Soul, Soula, Soulada, Soulafada, Soulafacta
		"name": "Soul",
		"id":"buff_soul",
		"type":"magic",
		"icon":"blk_mag",
		"fx" : "glow",
		"desc": "Increases the damage of the caster's next magic cast slightly.\nThis spell is often used by mages to surprise their foes with a large burst of explosive power.\n[color=red]Power grows, but life wanes. Alas, none take notice. ",
		"cost": 8,
		"effects": [
			{
				"type": "soul",
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
var consumable_dict = {
	"health_potion_weak":{
		"name" : "Health Potion (Small)",
		"id" : "health_potion_weak",
		"desc" : "A small red bottle of alchemical mixture used by field medics to rapidly and easily dress light wounds.\nIt bubbles and froths at the top of the mixture in a rather satisfying, if not unnerving, way.\nPlastered on the side is a worn brown label reading, 'Asclepius G, 100 units, distilled.'\nWritten below with charcoal is a tiny warning that reads, 'May induce vomiting, asphyxiation, momentary transcendence or other unnatural effects.'",
		"jokename" : "E-FUEL FOR GAMERS (Diet Size)",
		"jokedesc " : "A small green bottle of GAMER LIFE FLUIDS that BUBBLES with RAW GAMING ENERGY. The mixture has a white tinge to it, and it radiates a strange, musty odor. Written on the side in hot pink marker is a label reading, 'Estrogen 0.25L, Lard and Sugar mixture 0.50L, Gamer Tears 0.20L, Spite of God 5.0L, Actual Flavoring 0.0001L.'",
		"effects": 
		[
			{
				"type" : "restore",
				"param" : "hp",
				"amount" : [15,10]
			}
		]
	},
	"mana_potion_weak":{
		"name" : "Health Potion (Small)",
		"id" : "mana_potion_weak",
		"desc" : "A small blue bottle of alchemical mixture used by frontline mages to keep their mana stores full.\nStrangely enough, it sits rather stagnant within its container.\nPlastered on the side is a worn brown label reading, 'Volans P., 100 units, undistilled.'",
		"jokename" : "E-FUEL FOR GAMERS (Diet Size)",
		"jokedesc " : "A small blue bottle of GAMER LIFE FLUIDS that BUBBLES with RAW GAMING ENERGY. The mixture has a white tinge to it, and it radiates a strange, musty odor. Written on the side in hot pink marker is a label reading, 'Estrogen 0.25L, Lard and Sugar mixture 0.50L, Gamer Tears 0.20L, Spite of God 5.0L, Actual Flavoring 0.0001L.'",
		"effects": 
		[
			{
				"type" : "restore",
				"param" : "hp",
				"amount" : [15,10]
			}
		]
	},
}
var equip_dict = {
	"hiro_heirloom":{
		"name": "Hiro's Heirloom",
		"id" : "hiro_heirloom",
		"desc": """A strange medallion in Hiro's possession, which contains 
an unusual pebble-sized gemstone that radiates with energy. If 
touched, the gem shimmers with a vibrant, pulsing crimson light. 
The nostalgic red shine reminds Hiro of sanguine memories
held dear to his heart.""",
		"cost": 1,
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
		"desc": """A beautifully-forged curved sword from a distant land forgotten with time. 
Through an esoteric and long-gone process, the sharpened edge of the blade was 
forged to excel in slicing through unprotected flesh with its smooth cutting edge. 
Found in Alan's possession, though when questioned on the circumstances of its acquisition
he says he's simply 'always had it', and to 'stop asking questions.'""",
		"cost": 1,
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
		"desc": """A radiant, white-and-gold hoodie-style coat worn by Stella. 
The golden embellishments magnify the strength of magical power, and 
simultaneously appear to react to emotions that coalesce around 
the wearer by twitching energetically. According to Stella, 
these implements also approve of her wit, to the tired agreement of her companions.""",
		"cost": 1,
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
	},
	"cozy_fleece":{
		"name": "Enwool Fleece",
		"id" : "cozy_fleece",
		"desc": """A large, fluffy, and very warm bundle of enwool fleece. It's very
comfortable, and often used by travelers in cold, wintery areas. It's cute too!""",
		"cost": 1,
		"stats": {
			"hp": 20,
			"def" :4
		},
		"effects":[
			{
				"type":"resist",
				"param": "fire",
				"power": 10
			}
		]
	},
	"stella_stuffed_rabbit": {
		"name" : "Fluffy Stuffed Rabbit",
		"id" : "stella_stuffed_rabbit",
		"desc" : """A small, fluffy, nostalgic friend of Stella's. It was given by her mother,
		gives her a sense of warmth.""",
		"cost" : 1,
		"stats" : {
			"hp" : 10,
			"int" : 8,
			"wis" : 20
		},
		"effects" : [
			{
				"type" : "regen",
				"param" : "hp",
				"power" : 10,
				"length" : 5,
				"misc" : "sleep"
			}
		]
	}
}

var effect_dict = {
	"stat_buff" : {
		"name" : "Stat Buff",
		"type" : "buff",
		"id" : "stat_buff",
		"desc" : "A sharpened mind increases this stat for a duration.",
		"length" : 10,
		"freq" : 0,
		"effectType": null,
		"power": null
	},
	"poison_weak": {
		"name" : "Weak Poison",
		"type" : "debuff",
		"id" : "poison_weak",
		"desc" : "A weak poison which inflicts physical damage every few seconds.",
		"length" : 10,
		"freq" : 2,
		"effects" : 
			[
				{
					"type": "damage",
					"power": 5,
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
var partyPosition = Vector2()
var inventory = []
var money
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
		"money": money
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
	inventory.clear()
	for x in self.get_children():
		x.queue_free()
	money = 100
	party = [fabricate("hiro"),fabricate("stella"),fabricate("alan")]
	Master.party[0].equip (give_equipment("hiro_heirloom"))
	formation = [[-1,-1,-1],[2,0,1],[-1,-1,-1]]
	add_equip (give_equipment ("alan_foraged_blade"))
	add_equip (give_equipment ("stella_shard_coat"))
	#save_game()
	
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

func get_full (stat):
	match stat:
		#Attribute types
		"mhp" :
			return "Max HP"
		"mmp" :
			return "Max MP"
		"hp" :
			return "Max HP"
		"mp" :
			return "Max MP"
		"atk" :
			return "Attack"
		"def" : 
			return "Defense"
		"int" : 
			return "Intelligence"
		"wis" :
			return "Wisdom"
		"apt" :
			return "Aptitude"
		"spd" :
			return "Speed"
		"luk" : 
			return "Luck"
		#Ability types
		"phys" :
			return "physical"
		"ranged" :
			return "ranged"
		"magic" :
			return "magic"
		"wht_mag" :
			return "white magic"
		"blk_mag" :
			return "black magic"
		"buff" :
			return "support"
		#Stat descriptions
		"emhp" : 
			return "[color=#8e8e8e]How much damage this character can take. Defeat occurs at 0 HP.\n\nSpending SP on this stat restores 33% of HP."
		"emmp" : 
			return "[color=#8e8e8e]How many spells this character can cast. Cost varies depending on spell."
		"ehp" : 
			return "[color=#8e8e8e]How much damage this character can take. Defeat occurs at 0 HP.\n\nSpending SP on this stat restores 33% of HP."
		"emp" : 
			return "[color=#8e8e8e]A resource determining how many spells this character can cast, depending on their power."
		"eatk" : 
			return "[color=#8e8e8e]The measure of a character's physical prowess and skill with weaponry. Mostly governs attacks that use force to directly strike the enemy."
		"edef" : 
			return "[color=#8e8e8e]The measure of a character's resistance to physical attacks, as well as the ability to counterattack."
		"espd" :
			return "[color=#8e8e8e]Determines the frequency with which a character can take actions.\nAlso influences the power of certain quickness-based abilities."
		"eint" :
			return "[color=#8e8e8e]A measure of a character's innate smartness, which determines the strength of spellcasting and other magical attacks.\n"
		"ewis" :
			return "[color=#8e8e8e]A measure of a character's knowledge, which usually determines resistance to magical attacks and the power of White Magic."
		"eluk" :
			return "[color=#8e8e8e]How lucky a character is. Determines critical strike chance, among other more subtle effects."
		"eapt" :
			return "[color=#8e8e8e]Governs how many items a character can equip, and how powerful an item a character can equip."
	return "error!!"
func _ready():
	print ("singleton Master loaded successfully")
	#print (get_node("hiro_data").name)
	pass # Replace with function body.

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
