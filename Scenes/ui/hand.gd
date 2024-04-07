class_name Hand
extends HBoxContainer

@export var char_stats: CharacterStats

#needed to be able to instantiate new "card_ui"s
@onready var card_ui := preload("res://Scenes/card_ui/card_ui.tscn")



func add_card(card:Card) -> void:
	var new_card_ui: CardUI = card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.return_to_hand.connect(_on_card_return_to_hand)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.char_stats = char_stats

func discard_card(card:CardUI) -> void:
	card.queue_free()


func disable_hand() -> void:
	for card in get_children():
		card.disabled = true


func _on_card_return_to_hand(child:CardUI) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index := clampi(child.original_index, 0,get_child_count())
	move_child.call_deferred(child,new_index)
	child.set_deferred("disabled", false)
