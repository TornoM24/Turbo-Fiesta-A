extends Node


var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	_init()
	pass # Replace with function body.

# Loot by weight
var lootTable = [
  {
	item = 'sword',
	weight = 1 #10
  },
  {
	item = 'ore',
	weight = 1 #25
  },
  {
	item = 'shield',
	weight = 1 #35
  },
  {
	item = 'armor',
	weight = 1 #50
  },
  {
	item = null,
	weight = 2 #100
  },
]

var total_weight = 0
  
func _init():
	rng.randomize()
	for i in lootTable:
		total_weight += i.weight
		i.weight = total_weight
	
func drop():
	var itemCt = rng.randf_range(0,3)
	var dropList = []
	for x in range (0,itemCt):
		var result = rng.randi() % total_weight
		for i in lootTable:
			if result == i.weight && i.item != null:
				dropList.append (i.item)
	if !dropList.empty():
		return dropList
	else:
		return null

