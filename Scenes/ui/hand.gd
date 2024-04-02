class_name Hand
extends HBoxContainer

var cards_played_this_turn := 0

func _ready() -> void:
	Events.card_played.connect(_on_card_played)
	for child in get_children():
		var card_ui := child as CardUI
		card_ui.parent = self
		card_ui.return_to_hand.connect(_on_card_ui_return_to_hand)

func _on_card_played():
	cards_played_this_turn += 1
	

func _on_card_ui_return_to_hand(child:CardUI) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index := clampi(child.original_index - cards_played_this_turn, 0,get_child_count())
	move_child.call_deferred(child,new_index)
	child.set_deferred("disabled", false)
