extends PanelContainer

signal player_executes_action

func _ready():
	PlayerStats.connect("on_output_update", self, "on_PlayerStats_on_output_update")
	
func on_PlayerStats_on_output_update(output):
	var action = output.available_action
	if action:
		$Label.text = "Press (F) to " + action.get_text()
		visible = true
	else:
		visible = false

func _input(event):
	if visible and Input.is_action_just_pressed("action"):
		emit_signal("player_executes_action")
