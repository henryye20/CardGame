class_name PlayerHandler
extends Node

#time between card draws to not draw all at once
const HAND_DRAW_INTERVAL := 0.25

@export var hand: Hand

var character: CharacterStats


func start_battle(char_stats:CharacterStats) -> void:
	character = char_stats
	character.draw_pile = character.deck.duplicate(true)
	character.draw_pile.cards.shuffle()
	character.discard = CardPile.new()
	start_turn()

func start_turn() -> void:
	character.block = 0
	character.reset_mana()
	draw_cards(character.cards_per_turn)

func draw_card() -> void:
	hand.add_card(character.draw_pile.draw_card())
	
	
func draw_cards(amount:int) -> void:
	var tween := create_tween()
	#plays an animation inbetween each card draw
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	#connects the finished
	tween.finished.connect(
		func(): Events.player_hand_drawn.emit()
	)
