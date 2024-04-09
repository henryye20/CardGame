#class_name CardRewards
#extends ColorRect
#
#signal card_reward_selected(card: Card)
#
#const CARD_MENU_UI = preload("res://scenes/ui/card_menu_ui.tscn")
#
#@export var rewards: Array[Card] : set = set_rewards
#
#@onready var cards: HBoxContainer = %Cards
#@onready var skip_card_reward: Button = %SkipCardReward
#@onready var card_tooltip_popup: Control = %CardTooltipPopup
#
#@onready var take_button: Button = %TakeButton
#
#var selected_card: Card
#
#func _ready() -> void:
	#_clear_rewards()
	#_hide_tooltip()
	#
	#take_button.pressed.connect(
		#func(): 
			#card_reward_selected.emit(selected_card)
			#queue_free()
	#)
	#
	#skip_card_reward.pressed.connect(
		#func(): 
			#card_reward_selected.emit(null)
			#queue_free()
	#)
#
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_cancel"):
		#_hide_tooltip()
#
#
#func _clear_rewards() -> void:
	#for card: Node in cards.get_children():
		#card.queue_free()
		#
	#for card: Node in tooltip_card.get_children():
		#card.queue_free()
		#
	#selected_card = null
#
#
#func _show_tooltip(card: Card) -> void:
	#selected_card = card
	#card_tooltip_popup.show_tooltip(card)

