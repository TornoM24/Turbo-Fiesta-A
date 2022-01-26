extends Node

var playerStun = false
var prog = 0
var total = 0
var location
var title 
var dialog
var dialogCooldown = 0.1
var dProg = 0
var usable

signal completed 

func write ():
	var message = load ("res://ui/message_box_plain.tscn").instance()
	if location == "overworld":
		get_tree().get_root().get_node("Main/Player/Camera2D").add_child (message)
		message.position = Vector2(-160, 160)
		playerStun = true
	message.typewrite (title,dialog[prog],0.01)

func queue_dialog (node, location, title, dialog, type = "cinematic"):
	if type == "cinematic":
		#get_tree().get_root().get_node("Main/Player/Camera2D/Control").show_bars()
		pass
	if usable:
		usable = false
		dProg = 0
		prog = 0
		total = 0
		self.title = title
		self.location = location
		self.dialog = dialog
		for i in dialog:
			total += 1
		write()

func next_dialog ():
	prog += 1
	if prog < total:
		write()
	else:
		emit_signal ("completed")
		playerStun = false

func _process(delta):
	if playerStun == false:
		dProg += delta
		if dProg > dialogCooldown:
			usable = true
