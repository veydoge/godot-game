extends CanvasLayer

var currentItem = 0
var select = 0

func _on_closebtn_pressed():
	get_node("Anim").play("TransOut")
	SaveCoins.save_coin()
	get_tree().paused = false

func switchItem(select):
	for i in range(Global.items.size()):
		if select == i:
			currentItem = select
			get_node("Control/AnimSprite").play(Global.items[currentItem]["Name"])
			get_node("Control/Name").text = Global.items[currentItem]["Name"]
			get_node("Control/Des").text = Global.items[currentItem]["Des"]
			get_node("Control/Des").text += "\n Cost: " + str(Global.items[currentItem]["Cost"])
	
func _on_next_pressed():
	switchItem(currentItem + 1)

func _on_prev_pressed():
	switchItem(currentItem - 1)

func _on_buy_pressed():
	if SaveCoins.coin > Global.items[currentItem]["Cost"]:
		SaveCoins.coin -= Global.items[currentItem]["Cost"]
	else:
		get_node("Error").text = "Недостаточно монет"
