extends CanvasLayer


func _on_Start_pressed():
	$Start.hide()
	print("Attempting to open game interface!")

	

func _on_testbutton_pressed():
	print("Attempting to open combat interface!")
	get_node("/root/Global").goto_scene("res://scenes/combat.tscn")

