extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cir = get_parent().get_parent().get_parent().get_node ("circle")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const SMALL = 0.3
const LARGE = 0.5

func hide_buttons ():
	var buttons = [atk, def, spc, item]
	for b in buttons:
		b.disabled = true
	get_parent().get_parent().get_parent().get_parent().get_node ("actor2").hide()
	var cir = get_parent().get_parent().get_parent().get_node ("circle")
	#get_parent().show()
	tween.interpolate_property(cir, "scale",
		cir.scale, Vector2(SMALL,SMALL), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_property(cir, "modulate",
		cir.modulate, Color (1,1,1,0), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween_pos (atk, self.rect_position)
	tween_mod (atk, 0)
	tween_pos (def, self.rect_position)
	tween_mod (def, 0)
	tween_pos (spc, self.rect_position)
	tween_mod (spc, 0)
	tween_pos (item, self.rect_position)
	tween_mod (item, 0)
onready var tween = get_parent().get_parent().get_parent().get_parent().get_node ("Tween")
func tween_pos (node, pos):
	#print (node.name)
	tween.interpolate_property(node, "rect_position",
		null, pos, 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()

func tween_mod (node, mod):
	tween.interpolate_property(node, "modulate",
		node.modulate, Color (1,1,1,mod), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
onready var atk = get_parent().get_parent().get_node ("attack")
onready var def = get_parent().get_parent().get_node ("defend")
onready var spc = get_parent().get_parent().get_node ("special")
onready var item = get_parent().get_parent().get_node ("item")
func show_buttons ():
	var buttons = [atk, def, spc, item]
	for b in buttons:
		b.disabled = false
	#get_parent().hide()
	#get_parent().get_parent().get_parent().get_parent().get_node ("actor2").show()
	tween.interpolate_property(cir, "scale",
		Vector2 (SMALL,SMALL), Vector2(LARGE,LARGE), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_property(cir, "modulate",
		cir.modulate, Color (1,1,1,1), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween_pos (atk, Vector2 (56,8))
	tween_mod (atk, 1)
	#atk.show()
	atk.grab_focus()
	tween_pos (def, Vector2 (-33, 96))
	tween_mod (def, 1)
	#def.show()
	tween_pos (spc, Vector2 (144, 96))
	tween_mod (spc, 1)
	#spc.show()
	tween_pos (item, Vector2 (56,185))
	tween_mod (item, 1)
	#item.show()
onready var closer = get_parent().get_parent().get_parent().get_parent().get_node ("actor2")
func _process(delta):
	closer.global_position = rect_global_position + Vector2 (rect_size.x, rect_size.y)
	if atk.rect_position == self.rect_position:
		atk.hide()
	if def.rect_position == self.rect_position:
		def.hide()
	if spc.rect_position == self.rect_position:
		spc.hide()
	if item.rect_position == self.rect_position:
		item.hide()
	if !get_parent().get_parent().get_parent().get_parent().inReady:
		self.disabled = true
	else:
		self.disabled = false
	pass

func update_status():
	if !has_focus():
		hide_buttons()
	else:
		show_buttons()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_act_mouse_entered():
	get_parent().modulate = Color (1.2,1.2,1.2,1)
	pass # Replace with function body.


func _on_act_mouse_exited():
	get_parent().modulate = Color (1,1,1,1)
	pass # Replace with function body.
