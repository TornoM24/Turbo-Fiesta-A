extends Node


var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	rng.randf_range(0.0, 100.0) # Percent chance for items to drop
	
	pass # Replace with function body.

# Loot by weight (w)
var lootTable = [
  {
	item = 'balls',
	weight = 10
  },
  {
	item = 'sword',
	weight = 10
  },
  {
	item = 'shield',
	weight = 10
  },
  {
	item = 'milk',
	weight = 10
  },
]

var total_weight = 0
  
func init():
  # Calculate total weight and accumulate the weight for each item
	for i in lootTable:
		total_weight += i.weight
		i.weight = total_weight
	var loot = drop()
	print(loot)


func drop():
	var rng = RandomNumberGenerator.new()
	rng = rng.randi() % total_weight
	for i in lootTable:
	# if the RNG is <= item cumulated weight then drop that item
		if rng <= i.weight && i.item != null:
			return i
	return null

