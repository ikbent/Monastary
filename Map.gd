extends Spatial

var enabled = true
signal enter_well
signal exit_well
signal enter_church_portal
signal exit_church_portal
signal enter_near_tavern
signal exit_near_tavern
signal enter_tavern_door
signal exit_tavern_door
signal enter_city
signal exit_city
signal enter_nice_spot
signal exit_nice_spot
signal enter_bridge
signal exit_bridge


func enable():
	print("enable")
	enabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func disable():
	print("disable")
	enabled = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_ZoI_body_entered(body, id):
	if(body.name == "Player"):
		var signal_name = "enter_" + id
		print(signal_name)
		emit_signal(signal_name)
	else:
		print("it was ", body.name, ".") 

func _on_ZoI_body_exited(body, id):
	if(body.name == "Player"):
		var signal_name = "exit_" + id
		print(signal_name)
		emit_signal(signal_name)

func _on_Stairs_body_entered(_body):
	print("stairs")
