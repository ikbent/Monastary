extends Panel

var enabled = true


func _on_Script_player_stats_updated(player):
	if enabled:
		$Hydration.value = player.hydration
		$Grace.text = str(player.grace)
		$Devotion.text = str(player.devotion)
		$Gold.text = str(player.gold)
		$Clock.text = player.get_time().pretty()
		#print("Hydra", player.hydration, " gold ", player.gold, " grace ", player.grace, " devotion ", player.devotion)
	
func disable():
	enabled = false

func enable():
	enabled = true
