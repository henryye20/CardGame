extends Node2D

@export var char_stats: CharacterStats
@export var music: AudioStream
@export var wheelsfx:  AudioStream 
@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler as EnemyHandler
@onready var player: Player = $Player as Player
var run_stats: RunStats
func _ready() -> void:
	#normally done on a run not on level but only one battle so things would reset between battles
	var new_stats: CharacterStats = get_tree().get_first_node_in_group("run").character
	run_stats = get_tree().get_first_node_in_group("run").stats
	battle_ui.char_stats = new_stats
	player.stats = new_stats
	
	
	enemy_handler.child_order_changed.connect(_on_enemies_child_order_changed)
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.player_died.connect(_on_player_died)
	
	Events.gamble_played.connect(_gamble)
	
	start_battle(new_stats)
	battle_ui.initialize_card_pile_ui()

func start_battle(stats:CharacterStats) -> void:
	Events.battle_start.emit()
	get_tree().paused = false
	MusicPlayer.play(music,true)
	enemy_handler.reset_enemy_actions()
	player_handler.start_battle(stats)
	

#win condition - checks if there are no more enemies
func _on_enemies_child_order_changed() -> void:
	if enemy_handler.get_child_count() ==0:
		Events.battle_over_screen_requested.emit("Victory!", BattleOverPanel.Type.WIN)

func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()

func _on_player_died() -> void:
	Events.battle_over_screen_requested.emit("Game Over!", BattleOverPanel.Type.LOSE)
	
@onready var wheel_stuff :Control = %WheelStuff
@onready var wheel: Sprite2D = %Wheel

func _gamble() -> void:
	print("gambling")
	
	var x := randi_range(0,100)
	var result := 0
	var y := ""
	if x<5:
		#rotation degree where the image is rotated to win
		y = "win"
		result= randi_range(230,245)
	elif x<20:
		#$500
		y = "500"
		result= randi_range(50,85)
	elif x<35:
		#null
		y = "null"
		result = randi_range(95,135)
	elif x<55:
		y = "art"
		#art
		result = randi_range(150,215)
	elif x<75:
		y = "lose"
		#lose
		result = randi_range(255,315)
	elif x<=100:
		y = "100"
		#$100
		result = randi_range(-30,40)
	print(str(result))
	#get_tree().paused = true
	wheel_stuff.show()
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUART)
	var rotations := randi_range(2,6)
	tween.tween_property(wheel,"rotation_degrees",360*rotations+result,3)
	tween.tween_callback(SFXPlayer.play.bind(wheelsfx,false))
	tween.tween_interval(1)
	tween.tween_callback(_on_wheel_finish.bind(y))
	tween.tween_property(wheel,"rotation_degrees",0,0)
func _on_wheel_finish(y:String):
	wheel_stuff.hide()
	match y:
		"win":
			Events.battle_over_screen_requested.emit("Victory!", BattleOverPanel.Type.WIN)
		"lose":
			Events.battle_over_screen_requested.emit("Sorry!", BattleOverPanel.Type.LOSE)
		"100":
			run_stats.gold += 100
		"500":
			run_stats.gold += 100
		"null":
			pass
		"art":
			Events.art_enable.emit()
	
	
	

#debug stuff
#func _on_win_button_pressed():
#	Events.battle_over_screen_requested.emit("Victory!", BattleOverPanel.Type.WIN)
