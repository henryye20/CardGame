extends Node2D

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
func _ready() -> void:
	#normally done on a run not on level but only one battle so things would reset between battles
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats
	
	start_battle(new_stats)
	

func start_battle(stats:CharacterStats) -> void:
	player_handler.start_battle(stats)
