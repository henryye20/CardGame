class_name Run
extends Node

const BATTLE_SCENE := preload("res://Scenes/battle/battle.tscn")
const BATTLE_REWARD_SCENE := preload("res://Scenes/battle_reward/battle_reward.tscn")
const CAMPFIRE_SCENE := preload("res://Scenes/campfire/campfire.tscn")
const MAP_SCENE := preload("res://Scenes/map/map.tscn")
const SHOP_SCENE := preload("res://Scenes/shop/shop.tscn")
const TREASURE_SCENE := preload("res://Scenes/treasure/treasure.tscn")

@export var run_startup: RunStartup

@onready var current_view = $CurrentView
@onready var map_button = %MapButton
@onready var battle_button = %BattleButton
@onready var treasure_button = %TreasureButton
@onready var rewards_button = %RewardsButton
@onready var campfire_button = %CampfireButton
@onready var shop_button = %ShopButton

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
	_setup_event_connections()
	print("todo: make map")

func _change_view(scene:PackedScene) -> void:
	#deletes current scene
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	get_tree().paused = false
	
	var new_view := scene.instantiate()
	current_view.add_child(new_view)
	
	

func _setup_event_connections() -> void:
	Events.battle_won.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	Events.battle_reward_exited.connect(_change_view.bind(MAP_SCENE))
	Events.campfire_exited.connect(_change_view.bind(MAP_SCENE))
	Events.map_exited.connect(_change_view.bind(_on_map_exited))
	Events.shop_exited.connect(_change_view.bind(MAP_SCENE))
	Events.treasure_room_exited.connect(_change_view.bind(MAP_SCENE))
	
	battle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE_SCENE))
	map_button.pressed.connect(_change_view.bind(MAP_SCENE))
	rewards_button.pressed.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	treasure_button.pressed.connect(_change_view.bind(TREASURE_SCENE))
	
func _on_map_exited() -> void:
	print("todo:from map cheange view")
