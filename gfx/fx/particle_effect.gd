extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init (sp):
	get_node ("Sprite").frames = load ("res://gfx/fx/" + sp + ".tres")
	get_node ("Sprite").playing = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sprite_animation_finished():
	queue_free()
	pass # Replace with function body.
