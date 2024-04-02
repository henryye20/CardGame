extends Node

#events that should b accessed everywhere

#card events 
signal card_drag_started(card_ui:CardUI)
signal card_drag_ended(card_ui:CardUI)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_played(card:Card)
signal card_tooltip_requested(card:Card)
signal tooltip_hide_requested()

#player events
signal player_hand_drawn

