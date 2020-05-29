extends WindowDialog

var time_till_start
var effect

signal mass_done(donation, no_candles)

func _on_attend_mass(effect_mass):
	self.effect = effect_mass
	update()
	print("mass show")
	popup_centered()
	
func update():
	effect.attend_mass($sldCandles.value, $sldDonation.value)
	$labEffect.text = effect.text()


func _on_sldDonation_value_changed(value):
	update()


func _on_sldCandles_value_changed(value):
	update()

func _on_Button_pressed():
	hide()
	emit_signal("mass_done", effect)
