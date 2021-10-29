extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_item ("Poopie")
	add_item ("Stinkie")
	get_popup().rect_global_position = self.rect_global_position #+ Vector2(0,rect_size.y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
