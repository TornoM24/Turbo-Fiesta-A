extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cir = get_parent().get_parent().get_node ("circle")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const SMALL = 0.3
const LARGE = 0.5

func hide_buttons ():
	show()
	tween.interpolate_property(cir, "scale",
		cir.scale, Vector2(SMALL,SMALL), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_property(cir, "modulate",
		cir.modulate, Color (1,1,1,0), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween_pos (get_parent().get_node ("attack"), self.rect_position)
	tween_mod (get_parent().get_node ("attack"), 0)
	#get_parent().get_node ("attack").hide()
	tween_pos (get_parent().get_node ("defend"), self.rect_position)
	tween_mod (get_parent().get_node ("defend"), 0)
	#get_parent().get_node ("defend").hide()
	tween_pos (get_parent().get_node ("special"), self.rect_position)
	tween_mod (get_parent().get_node ("special"), 0)
	#get_parent().get_node ("special").hide()
	tween_pos (get_parent().get_node ("item"), self.rect_position)
	tween_mod (get_parent().get_node ("item"), 0)
	#get_parent().get_node ("item").hide()
onready var tween = get_parent().get_parent().get_parent().get_node ("Tween")
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

func show_buttons ():
	hide()
	tween.interpolate_property(cir, "scale",
		Vector2 (SMALL,SMALL), Vector2(LARGE,LARGE), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_property(cir, "modulate",
		cir.modulate, Color (1,1,1,1), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween_pos (get_parent().get_node ("attack"), Vector2 (56,32))
	tween_mod (get_parent().get_node ("attack"), 1)
	get_parent().get_node ("attack").show()
	get_parent().get_node ("attack").grab_focus()
	tween_pos (get_parent().get_node ("defend"), Vector2 (-8, 96))
	tween_mod (get_parent().get_node ("defend"), 1)
	get_parent().get_node ("defend").show()
	tween_pos (get_parent().get_node ("special"), Vector2 (120, 96))
	tween_mod (get_parent().get_node ("special"), 1)
	get_parent().get_node ("special").show()
	tween_pos (get_parent().get_node ("item"), Vector2 (56,160))
	tween_mod (get_parent().get_node ("item"), 1)
	get_parent().get_node ("item").show()

func _process(delta):
	if get_parent().get_node ("attack").rect_position == self.rect_position:
		get_parent().get_node ("attack").hide()
	if get_parent().get_node ("defend").rect_position == self.rect_position:
		get_parent().get_node ("defend").hide()
	if get_parent().get_node ("special").rect_position == self.rect_position:
		get_parent().get_node ("special").hide()
	if get_parent().get_node ("item").rect_position == self.rect_position:
		get_parent().get_node ("item").hide()
	if !get_parent().get_parent().get_parent().inReady:
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
