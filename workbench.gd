extends CanvasLayer

var currentItem = 0
var select = 0

func _on_closebtn_pressed():
	get_node("AnimationPlayer").play("TrainOut")
	get_tree().paused = false

func switchItem(select):
	for i in range(Global.resources.size()):
		if select == i:
			currentItem = select
			get_node("Control/AnimSprite").play(Global.resources[currentItem]["Name"])
			get_node("Control/Name").text = Global.resources[currentItem]["Name"]
			get_node("Control/Des").text = Global.resources[currentItem]["Des"]
			get_node("Control/Des").text += "\n Cost: " + str(Global.resources[currentItem]["Cost"])
	
func _on_next_pressed():
	switchItem(currentItem + 1)

func _on_prev_pressed():
	switchItem(currentItem - 1)

func _on_buy_pressed():
	pass
	#get_node("Error").text = "Недостаточно монет"
