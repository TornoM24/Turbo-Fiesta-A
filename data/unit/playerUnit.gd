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
var originalStats = {
		"mhp" : 0,
		"mmp" : 0,
		"hp" : 0,
		"mp" : 0,
		"atk" : 0,
		"def" : 0,
		"int" : 0,
		"wis" : 0,
		"apt" : 0,
		"spd" : 0,
		"luk" : 0
	}
var bonus = {
		"mhp" : 0,
		"mmp" : 0,
		"hp" : 0,
		"mp" : 0,
		"atk" : 0,
		"def" : 0,
		"int" : 0,
		"wis" : 0,
		"apt" : 0,
		"spd" : 0,
		"luk" : 0
	}
var equipBonus = {}
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

var affiliation = "ally"
var type
var ability 
var target
# Called when the node enters the scene tree for the first time.
func _ready():
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
var casting = false
onready var tween = get_node ("Tween")
func enemyDie():
	if !dying:
		dying = true
		tween.interpolate_property(get_node ("UnitSprite"), "modulate",
			Color (1,1,1,1), Color (0.7,0,1,0), 1,
		Tween.TRANS_QUART, Tween.EASE_IN)
		tween.start()
func allyDie():
	get_node ("AnimatedSprite").hide()
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
	#get_node ("AnimatedSprite").show()
	get_node ("Attack").hide()
	get_node ("Attack").frame=0
	get_node ("Attack").playing=false
var singleRun = false
var timerComplete

func decay_effects(delta):
	for eff in tempEffects:
		#print (originalStats)
		stats[eff.effectType] = originalStats [eff.effectType] + eff.realPower
		if !Master.atb_paused:
			eff.timer += delta
		if eff.timer >= 1:
			eff.length -= 1
			eff.timer = 0
		if eff.length <= 0:
			stats[eff.effectType] = originalStats [eff.effectType]
			eff.particle.queue_free()
			tempEffects.erase (eff)
			pass
	pass

func _process(delta):
	decay_effects (delta)
	if inDead:
		allyDie()
	if !dying:
		updateResources()
		atb_prog += delta
		if !inDead && !Master.atb_paused:
			if atb_prog >= 0.001 && !inAnimation &&!animStun:
				atb_val += float (stats.spd)/30
				atb_prog = 0
		if inAnimation:		
			if type == "magic":
				casting = true
				get_node ("AnimatedSprite").hide()
				var timer = get_node ("Timer")
				if ability.has ("castTime"):
					timer.wait_time = ability.castTime
				else:
					timer.wait_time = 4
				get_node ("TextureProgress").max_value = timer.wait_time
				timer.start()
			if type !="ranged" and type!= "magic":
				var all = false
				if singleRun:
					for x in ability.effects:
						if x.target == "all enemies":
							all = true
					tween.interpolate_property(self, "position",
						origin, target.position + Vector2 (150,0), 0.5,
					Tween.TRANS_QUART, Tween.EASE_OUT)
					tween.start()
					singleRun = false
				
				if (global_position == target.position + Vector2 (150,0)) or all:
					animReset()
					inAnimation = false
			else:#if type *is* magic then
				animReset()
				inAnimation = false
		if inRecovery:
			if type == "magic":
				casting = false
			if type !="ranged" and type!= "magic":
				if singleRun:
					tween.interpolate_property(self, "position",
						null, origin, 0.5,
					Tween.TRANS_QUART, Tween.EASE_OUT)
					tween.start()
					singleRun = false
				if global_position == origin:
					animBreak()
					get_node ("AnimatedSprite").show()
					inRecovery = false
					animStun = false
			else: #if type *is* magic then
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
	get_node("HPBar").hide()
	get_node("ATBBar").hide()
	animStun = true
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

func create_message (message):
	
	var msg = load ("res://gfx/fx/message.tscn").instance()
	msg.init (message)
	add_child (msg)

func parse_buff (buff):
	print ("gave " + unitName + " the buff " + buff.name)
	buff ["timer"] = 0
	buff ["realPower"] = int (stats[buff.effectType] * float(buff.power)/100)
	buff ["particle"] = load ("res://gfx/fx/particle_effect.tscn").instance()
	buff.particle.get_node ("Sprite").hide()
	add_child (buff.particle)
	#stats[buff.effectType] += buff.realPower
	#stats[buff.effectType] += bonus[buff.effectType]
	tempEffects.append (buff)

func shake(direction):
	var par = 0
	if direction == "back":
		par = -20
	else:
		par = 20
	tween.interpolate_property(get_node ("AnimatedSprite"), "position",
		null, get_node ("AnimatedSprite").position + Vector2 (par, 0), 0.5,
	Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.interpolate_property(get_node ("UnitSprite"), "position",
		null, get_node ("UnitSprite").position + Vector2 (par, 0), 0.5,
	Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()

func sprite_attack (abi, tar):
	ability = abi
	type = ability.type
	target = tar
	inAnimation = true
	singleRun = true
	animStun = true
	if ability.has ("quote"):
		create_message (ability.quote)
	if type == "magic":
		get_node ("Attack").frames = load ("res://data/unit/"+unitName+"/art/"+unitName+"_cast.tres")
		get_node ("CastParticles").emitting = true
	else:
		get_node ("Attack").frames = load ("res://data/unit/"+unitName+"/art/"+unitName+"_attack.tres")
	yVelo = -2.6
	origin = global_position
	

func _on_Select_pressed():
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
	if ability.type != "magic": 
		get_node ("AnimatedSprite").show()
		get_node ("Attack").hide()
		singleRun = true
		process_end()
	pass # Replace with function body.


func _on_Timer_timeout():
	singleRun = true
	get_node ("AnimatedSprite").show()
	tween.interpolate_property(get_node ("AnimatedSprite"), "modulate",
		Color (1.2,1.2,1.2,1), Color (1,1,1,1), 1,
	Tween.TRANS_QUART, Tween.EASE_IN)
	tween.start()
	process_end()
	pass # Replace with function body.
onready var bar = get_node ("TextureProgress")

func _on_Tween_tween_all_completed():
	tween.interpolate_property(get_node ("AnimatedSprite"), "position",
		null, Vector2(16,28), 0.5,
	Tween.TRANS_QUART, Tween.EASE_IN)
	tween.interpolate_property(get_node ("UnitSprite"), "position",
		null, Vector2(24,50), 0.5,
	Tween.TRANS_QUART, Tween.EASE_IN)
	tween.start()
	pass # Replace with function body.
