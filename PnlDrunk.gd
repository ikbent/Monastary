extends WindowDialog

func _ready():
	PlayerStats.connect("event_raised", self, "on_PlayerStats_event_raised")

var effect
var audio_stream_player

func on_PlayerStats_event_raised(event):
	self.get_stylebox("panel").set_texture(event.texture)
	$labExplanation.text = event.explanation + "\n\n" + event.effect.text()
	$Button.text = event.latin_quote
	self.effect = event.effect
	self.audio_stream_player = event.audio_stream_player
	if audio_stream_player:
		audio_stream_player.play()
	popup_centered()

func _on_Button_pressed():
	if audio_stream_player:
		audio_stream_player.stop()
	PlayerStats.execute_effect(effect)
	hide()
