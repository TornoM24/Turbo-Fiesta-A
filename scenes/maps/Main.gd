extends Node2D

var rand = RandomNumberGenerator.new()
export(PackedScene) var mob_scene
var timer = null
var percent = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)

	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.set_wait_time(1.0)
	timer.set_one_shot(false) # Make sure it loops
	timer.start()

func _on_Timer_timeout():
	if (!spawnEnemy()):
		percent += 0.05
	else:
		timer.stop()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnEnemy():
	if (rand.randf_range(0.0, 100.0) <= percent):
		var mob = mob_scene.instance()
		add_child(mob)
	else:
		return false
	
	
