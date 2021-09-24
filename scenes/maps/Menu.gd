extends VBoxContainer


func _on_Start_pressed():
	$Start.hide()
	print("Attempting to open game interface!")
	get_node("/root/Global").goto_scene("res://scenes/maps/hub.tscn")

func _on_testbutton_pressed():
	print("Attempting to open combat interface!")
	get_node("/root/Global").goto_scene("res://scenes/combat.tscn")

