extends Node2D

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
	"buff_light_atk":{
		"name": "FOCUS ~Seeing Red~",
		"id":"buff_light_atk",
		"type":"magic",
		"icon":"magic",
		"fx" : "glow",
		"castTime" : 3,
		"desc": "User focuses, granting lightly increased attack power.",
		"cost": 10,
		"effects": [
			{
				"type": "buff",
				"target": "self",
				"param": "atk",
				"power": 50,
				"duration": 30
			}
		]
	},
	"buff_super_atk":{
		"name": "FOCUS ~Mind Ablaze~",
		"id":"buff_super_atk",
		"type":"magic",
		"icon":"magic",
		"fx" : "glow",
		"castTime" : 8,
		"desc": "User ignites their fighting spirit, granting heavily increased attack power but taking an immense amount of time to execute.",
		"cost": 10,
		"effects": [
			{
				"type": "buff",
				"target": "self",
				"param": "atk",
				"power": 50,
				"duration": 30
			}
		]
	},
	"attack_scarlet_razor_hiro":{
		"name": "Razorcut",
		"id":"attack_scarlet_razor_hiro",
		"type":"phys",
		"icon":"razor",
		"fx" : "slash",
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
	"attack_iai":{
		"name": "Iai Draw",
		"id":"attack_iai",
		"type":"phys",
		"icon":"katana",
		"fx" : "slash",
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
		"desc": "User steels their resolve, gaining bonus DEF and ATK and attracting enemy attention.\n[color=gray]\nI won't let it happen again...!",
		"cost": 20,
		"effects": [
			{
				"type": "buff",
				"target": "self",
				"param": "atk",
				"power": 20,
				"duration": 30
			},
			{
				"type": "buff",
				"target": "self",
				"param": "def",
				"power": 30,
				"duration": 30
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
		"desc": "Flings stars at an enemy, dealing light/magic damage.\n[color=gray]",
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
	"attack_interceptor":{
		"name": "Igelschütze",
		"id":"attack_interceptor",
		"type":"ranged",
		"icon":"shoot2",
		"fx" : "shoot",
		"desc": "Shoots a target unit with built-in weaponry, dealing light physical damage over ten shots.\n[color=gray]'Stand still. Or move. It's all the same to me, really.'",
		"cost": 0,
		"effects": [
			{
				"type": "damage",
				"target": "single",
				"scaling" : ["atk"],
				"elements": ["physical"],
				"power": 100,
				"hits":10,
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
