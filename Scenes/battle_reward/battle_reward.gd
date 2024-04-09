class_name BattleReward
extends Control
const REWARD_BUTTON = preload("res://scenes/ui/reward_button.tscn")
const GOLD_ICON := preload("res://MyArt/moneybag.png")
const GOLD_TEXT := "%s gold"


@export var run_stats: RunStats


@onready var rewards: VBoxContainer = %Rewards


func _ready() ->void:
	for node: Node in rewards.get_children():
		node.queue_free()
	
	
func add_gold_reward(amount: int) -> void:
	var gold_reward := REWARD_BUTTON.instantiate() as RewardButton
	gold_reward.reward_icon = GOLD_ICON
	gold_reward.reward_text = GOLD_TEXT % amount
	gold_reward.pressed.connect(_on_gold_reward_taken.bind(amount))
	rewards.add_child.call_deferred(gold_reward)

func _on_gold_reward_taken(amount: int) -> void:
	if not run_stats:
		return
	
	run_stats.gold += amount

func _on_back_button_pressed():
	Events.battle_reward_exited.emit()
