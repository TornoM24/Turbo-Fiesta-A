extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hide_buttons ():
	show()
	get_parent().get_node ("attack").rect_position = self.rect_position
	get_parent().get_node ("attack").hide()
	get_parent().get_node ("defend").rect_position = self.rect_position
	get_parent().get_node ("defend").hide()
	get_parent().get_node ("special").rect_position = self.rect_position
	get_parent().get_node ("special").hide()
	get_parent().get_node ("item").rect_position = self.rect_position
	get_parent().get_node ("item").hide()

func show_buttons ():
	hide()
	get_parent().get_node ("attack").rect_position = Vector2 (56,32)
	get_parent().get_node ("attack").show()
	get_parent().get_node ("attack").grab_focus()
	get_parent().get_node ("defend").rect_position = Vector2 (-8, 96)
	get_parent().get_node ("defend").show()
	get_parent().get_node ("special").rect_position = Vector2 (120, 96)
	get_parent().get_node ("special").show()
	get_parent().get_node ("item").rect_position = Vector2 (56,160)
	get_parent().get_node ("item").show()

func _process(delta):
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
