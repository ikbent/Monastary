extends WindowDialog

var effect_tavern
signal tavern_done(effect_tavern)

func _on_visit_tavern(effect_tavern):
	self.effect_tavern = effect_tavern
	$sldWine.max_value = effect_tavern.max_no_glasses
	update()
	popup_centered()

func update():
	effect_tavern.set_consumption($sldWine. value, $sldFood.value)
	$labEffect.text = effect_tavern.text()

func _on_sldWine_value_changed(value):
	update()

func _on_sldFood_value_changed(value):
	update()

func _on_Button_pressed():
	hide()
	emit_signal("tavern_done", effect_tavern)
