extends Node


var rng = RandomNumberGenerator.new()
var loot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Loot by weight
var lootTable = [
  {
	item = 'sword',
	weight = 10 #10
  },
  {
	item = 'ore',
	weight = 15 #25
  },
  {
	item = 'shield',
	weight = 10 #35
  },
  {
	item = 'armor',
	weight = 15 #50
  },
  {
	item = null,
	weight = 50 #100
  },
]

var total_weight = 0
  
func _init():
	for i in lootTable:
		total_weight += i.weight
		i.weight = total_weight
	loot = _drop()
	print(loot)
	pass
	
func _drop():
	randomize()
	rng = rng.randi() % total_weight
	for i in lootTable:
		if rng <= i.weight && i.item != null:
			return i
	return null

