extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var origin = Vector2()

var mhp = 100
var hp = 90

var mmp = 100
var mp = 100

var atb_prog = 0
var atb_val = 0

var stats = {}
var abilities = []
var effects = [] 
var tempEffects = []

var unitName = "Aou Mogis"
var selected = false

var queue = []
var reference

var inAnimation = false
var inRecovery = false
var animStun = false
var alive = true
var inDead = false

var type
var ability 
var target
# Called when the node enters the scene tree for the first time.
func _ready():
	#var timeTween = Tween.new()
	#add_child(timeTween)
	pass # Replace with function body.

func updateResources():
	var hpb = get_node("HPBar")
	var mpb = get_node("MPBar")
	hpb.value = (float(stats.hp)/stats.mhp)*100
	#mpb.value =  (float(stats.mp)/
const SPEED_MOD = 2000
var yVelo = -1.3
var dying
var deathAnimFinished = false
func enemyDie():
	dying = true
func allyDie():
	#show()
	get_node ("AnimatedSprite").hide()
	#get_node ("UnitSprite").texture = load ("res://data/unit/"+unitName+"/art/"+unitName+"_dead.png")
	get_node ("UnitSprite").texture = load ("res://data/unit/hiro/art/hiro_dead.png")
	get_node ("UnitSprite").show()

func effCall ():
	get_parent().causeEffect (target,self,ability)

func animReset():
	get_node ("AnimatedSprite").hide()
	get_node ("Attack").show()
	get_node ("Attack").frame=0
	get_node ("Attack").playing=true
	
func animBreak():
	get_node ("AnimatedSprite").show()
	get_node ("Attack").hide()
	get_node ("Attack").frame=0
	get_node ("Attack").playing=false
var singleRun = false
var timerComplete
func _process(delta):
	if inDead:
		allyDie()
	if !dying:
		var tween = get_node ("Tween")
		updateResources()
		atb_prog += delta
		if !inDead:
			if atb_prog >= 0.01 && !inAnimation &&!animStun:
				atb_val += float (stats.spd)/10
				atb_prog = 0
		if inAnimation:
			if type !="ranged" and type!= "magic":
				if singleRun:
					tween.interpolate_property(self, "position",
						origin, target.position + Vector2 (50,0), 0.5,
					Tween.TRANS_QUART, Tween.EASE_OUT)
					tween.start()
					singleRun = false
				
				if global_position == target.position + Vector2 (50,0):
					animReset()
					inAnimation = false
			else:
				animReset()
				inAnimation = false
		if inRecovery:
			if type !="ranged" and type!= "magic":
				if singleRun:
					tween.interpolate_property(self, "position",
						null, origin, 0.5,
					Tween.TRANS_QUART, Tween.EASE_OUT)
					tween.start()
					singleRun = false
				if global_position == origin:
					animBreak()
					inRecovery = false
					animStun = false
			else:
				animBreak()
				inRecovery = false
				animStun = false
		if stats.hp <= 0:
			stats.hp = 0
			alive = false
	else:
		die()
		yield(get_tree().create_timer(1), "timeout")
		deathAnimFinished = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func die():
	var spr = get_node ("UnitSprite")
	for x in range (0,20):
		get_node("HPBar").hide()
		get_node("ATBBar").hide()
		animStun = true
		spr.modulate.r = 1.5
		spr.modulate.b = 1.5
		spr.modulate.a -= 0.05
func glow ():
	var spr = get_node ("UnitSprite")
	yield(get_tree().create_timer(0.10), "timeout")
	spr.modulate.r = 1.5
	spr.modulate.g = 1.5
	spr.modulate.b = 1.5
	
const GLOW_SPEED = 0.075
func glow_cast (abi, tar):
	ability = abi
	type = ability.type
	target = tar
	animStun = true
	#inAnimation = true
	var spr = get_node ("UnitSprite")
	for x in range (0,3):
		spr.modulate.r = 1.5
		spr.modulate.g = 1.5
		spr.modulate.b = 1.5
		yield(get_tree().create_timer(GLOW_SPEED), "timeout")
		spr.modulate.r = 1.0
		spr.modulate.g = 1.0
		spr.modulate.b = 1.0
		yield(get_tree().create_timer(GLOW_SPEED), "timeout")
	effCall () 
	animStun = false
	spr.modulate.r = 1.0
	spr.modulate.g = 1.0
	spr.modulate.b = 1.0

func sprite_attack (abi, tar):
	ability = abi
	type = ability.type
	target = tar
	#print (type)
	inAnimation = true
	singleRun = true
	animStun = true
	if type == "magic":
		get_node ("Attack").frames = load ("res://data/unit/"+unitName+"/art/"+unitName+"_cast.tres")
		get_node ("CastParticles").emitting = true
	else:
		get_node ("Attack").frames = load ("res://data/unit/"+unitName+"/art/"+unitName+"_attack.tres")
	yVelo = -2.6
	origin = global_position
	

func _on_Select_pressed():
	print ("Selected the unit "+unitName)
	selected = true
	pass # Replace with function body.


func _on_Select_mouse_entered():
	var x = get_node ("UnitSprite")
	var y = get_node ("AnimatedSprite")
	x.modulate.r = 1.2
	x.modulate.g = 1.2
	x.modulate.b = 1.2
	y.modulate.r = 1.2
	y.modulate.g = 1.2
	y.modulate.b = 1.2
	pass # Replace with function body.


func _on_Select_mouse_exited():
	var x = get_node ("UnitSprite")
	var y = get_node ("AnimatedSprite")
	x.modulate.r = 1
	x.modulate.g = 1
	x.modulate.b = 1
	y.modulate.r = 1
	y.modulate.g = 1
	y.modulate.b = 1
	pass # Replace with function body.

func process_end():
	inRecovery = true
	effCall()
	yVelo = -1.7
	get_node ("CastParticles").emitting = false

func _on_Attack_animation_finished():
	get_node ("AnimatedSprite").show()
	
	if ability.type != "magic": 
		get_node ("Attack").hide()
		singleRun = true
		process_end()
	else:
		print ("waiting for timer")
		get_node ("AnimatedSprite").hide()
		get_node ("Timer").start()
	pass # Replace with function body.


func _on_Timer_timeout():
	singleRun = true
	process_end()
	pass # Replace with function body.
