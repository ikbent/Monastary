extends Node

var running = true

const DEHYDRATION = 8.0 / 24.0 / 3600.0
signal player_stats_updated(player)
signal attend_mass(effect_mass)

var zoi = []

func pause():
	running = false
	
func unpause():
	running = true

const GAME_TIME_RATIO = 60
func _process(delta):
	if running:
		var delta_game_seconds = delta * GAME_TIME_RATIO
		eval_events(delta_game_seconds)
		pass_game_time(delta_game_seconds)
		emit_signal("player_stats_updated", PlayerStats)
		eval_events(delta_game_seconds)

var Action = load("res://script/Action.gd")
var Insight = load("res://script/Insight.gd")
var Sin = load("res://script/Sin.gd")

func eval_events(delta_game_seconds):
	var last_zoi = null
	if (!zoi.empty()): last_zoi = zoi.back()
	var ZoI = load("res://script/ZoI.gd")
	if last_zoi and last_zoi is ZoI:
		last_zoi.process_zoi(delta_game_seconds)
	PlayerStats.switch_output()

func pass_game_time(delta_game_seconds):
	PlayerStats.hydration -= DEHYDRATION * delta_game_seconds
	PlayerStats.pass_seconds(delta_game_seconds)

func _on_PnlAction_player_executes_action():
	var action = PlayerStats.output.available_action
	if action:
		action.execute()

##################### Church #######################
	
func _on_Map_enter_church_portal():
	zoi.append($NearChurchPortal)

func _on_Map_exit_church_portal():
	zoi.erase($NearChurchPortal)

func _on_Map_enter_near_tavern():
	zoi.append($NearTavern)

func _on_Map_exit_near_tavern():
	zoi.erase($NearTavern)

func _on_Map_enter_tavern_door():
	zoi.append($TavernDoor)

func _on_Map_exit_tavern_door():
	zoi.erase($TavernDoor)
	

func _on_Map_enter_well():
	zoi.append($NearWell)

func _on_Map_exit_well():
	zoi.erase($NearWell)	

func _on_Map_enter_nice_spot():
	zoi.append($Monastary)

func _on_Map_exit_nice_spot():
	zoi.erase($Monastary)

func _on_Map_enter_bridge():
	zoi.append($Bridge)

func _on_Map_exit_bridge():
	zoi.erase($Bridge)
