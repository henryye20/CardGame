class_name Run
extends Node

const BATTLE_SCENE := preload("res://Scenes/battle/battle.tscn")
const BATTLE_REWARD_SCENE := preload("res://scenes/battle_reward/battle_reward.tscn")
const MAP_SCENE := preload("res://Scenes/map/map.tscn")

@export var buyable_cards:Array[Card]
@export var run_startup: RunStartup
var i := 0

var times_gambled := 0
var gold_to_add := 80
var cost := 50
const heal_cost := 30
const mana_cost := 300
@onready var wheel_stuff = $WheelStuff
@onready var wheel_picker = $WheelStuff/WheelPicker

@onready var current_view = $CurrentView
@onready var gold_ui: GoldUI = %GoldUI
@onready var deck_button: CardPileOpener = %DeckButton
@onready var deck_view:CardPileView = %DeckView

@onready var buy_button = %BuyButton
@onready var heal_button = %HealthButton
@onready var mana_button = %ManaButton
@onready var battle_button = %BattleButton


@onready var health_label = %HealthLabel


var stats:RunStats
var character: CharacterStats


func _ready() -> void:
	
		
	if not run_startup:
		return
	
	match run_startup.type:
		RunStartup.Type.NEW_RUN:
			character = run_startup.picked_character.create_instance()
			_start_run()
		RunStartup.Type.CONTINUED_RUN:
			print("TODO: load prev run")

func _start_run() -> void:
	stats = RunStats.new()
	health_label.text = str(character.health) + "/" + str(character.max_health)
	_setup_event_connections()
	_setup_top_bar()
	
	

func _setup_top_bar():
	gold_ui.run_stats = stats
	deck_button.card_pile = character.deck
	deck_view.card_pile = character.deck
	deck_button.pressed.connect(deck_view.show_current_view.bind("Deck"))

func _change_view(scene:PackedScene) -> Node:
	#deletes current scene
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	get_tree().paused = false
	
	var new_view := scene.instantiate()
	current_view.add_child(new_view)
	
	return new_view

func _setup_event_connections() -> void:
	
	Events.battle_won.connect(_on_battle_won)
	Events.battle_reward_exited.connect(func(): current_view.get_child(0).queue_free())
	
	Events.player_hit.connect(_update_health)
	
	Events.double_played.connect(_double_mana)
	Events.gamble_played.connect(_gamble)
	
	battle_button.pressed.connect(_on_battle_button_press)
func _on_battle_won() ->void:
	var reward_scene := _change_view(BATTLE_REWARD_SCENE) as BattleReward
	reward_scene.run_stats = stats
	gold_to_add += randi_range(11,39)
	reward_scene.add_gold_reward(gold_to_add)
	_check_gold(cost,buy_button)
	_check_gold(heal_cost,heal_button)
	_check_gold(mana_cost,mana_button)
	battle_button.disabled = false
func _on_battle_button_press():
	_change_view(BATTLE_SCENE)
	battle_button.disabled = true

#card buy button
func _on_buy_button_pressed():
	randi_range(0,buyable_cards.size()-1)
	character.deck.add_card(buyable_cards[i])
	cost += 10
	stats.gold -= cost
	_check_gold(cost,buy_button)
	buy_button.text = "Buy Random Card $%s" % cost
	
#checks to see if enough gold for certain button if not enough disables button
func _check_gold(cost:int,button):
	if stats.gold <cost:
		button.disabled = true
	else: 
		button.disabled = false

# heal button this is inefficient coding but I'm too tired to make it better
func _on_health_button_pressed():
	var new_health:= character.health
	new_health += 10
	
	character.set_health(new_health)
	_update_health()
	stats.gold -= heal_cost
	_check_gold(heal_cost,heal_button)

func _update_health(): 
	health_label.text = str(character.health) + "/" + str(character.max_health)
# mana button
func _on_mana_button_pressed():
	character.max_mana +=1
	stats.gold-= mana_cost
	_check_gold(mana_cost,mana_button)

#50% chance to double mana
func _double_mana():
	var x = randi_range(0,1)
	var new_mana := character.mana
	if x == 1:
		new_mana *= 2
	character.set_mana(new_mana)


func _gamble():
	times_gambled +=1

	
	
