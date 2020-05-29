extends PanelContainer

func _ready():
	PlayerStats.connect("on_output_update", self, "on_PlayerStats_on_output_update")

func on_PlayerStats_on_output_update(output):
	if(output.message):
		$Label.text = output.message
		visible = true
	else:
		visible = false
