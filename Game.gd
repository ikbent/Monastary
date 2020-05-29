extends Node

func _input(event):
	if Input.is_action_pressed("escape"):
		pause()
	if Input.is_action_pressed("cheat"):
		if Input.is_key_pressed(KEY_W):
			PlayerStats.hydration += .1
		if Input.is_key_pressed(KEY_S):
			PlayerStats.hydration -= .1

		if Input.is_key_pressed(KEY_Q):
			PlayerStats.pass_seconds(60)
		if Input.is_key_pressed(KEY_A):
			PlayerStats.pass_seconds(-60)


		if Input.is_key_pressed(KEY_E):
			PlayerStats.devotion  += 1
		if Input.is_key_pressed(KEY_D):
			PlayerStats.devotion -= 1

func pause():
	$Map.disable()
	$Script.pause()
	$Stats.disable()
	
func unpause():
	$Map.enable()
	$Script.unpause()
	$Stats.enable()


func _on_PnlDrunk_about_to_show():
	pause()

func _on_PnlDrunk_popup_hide():
	unpause()

func _on_WndMass_about_to_show():
	pause()

func _on_WndMass_popup_hide():
	unpause()
